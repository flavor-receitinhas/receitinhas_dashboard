import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/sembast_database.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/store_sembast_enum.dart';
import 'package:dash_receitas/src/core/services/preference/user_preference/key_preference.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/components/cookie_toast.dart';
import 'package:dash_receitas/src/features/auth/domain/entities/user_entity.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_serivce.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final PersistentDatabaseSembast prefs;
  final AuthService _authService;

  AuthController(this._authService, this.prefs);

  StateManager _state = StateManager.initial;
  String _error = '';

  StateManager get state => _state;
  String get error => _error;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = true;

  void _setState(StateManager newState) {
    _state = newState;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    _setState(StateManager.error);
  }

  Future<void> login(BuildContext context) async {
    try {
      _setState(StateManager.loading);

      if (!(await _validateLogin())) {
        if (context.mounted) {
          CookieToast.show(context, message: _error, type: ToastType.error);
        }
        return;
      }

      final UserEntity credential = await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      await prefs.update(
        id: KeyPreferences.userSession.name,
        store: StoreSembastEnum.user,
        objeto: UserEntity(id: credential.id, email: credential.email).toJson(),
      );

      _setState(StateManager.success);
    } catch (e) {
      String errorMessage = 'Erro desconhecido.';

      if (e is FirebaseAuthException) {
        errorMessage = e.message ?? errorMessage;
      } else {
        final raw = e.toString();
        errorMessage = raw.startsWith('Exception: ')
            ? raw.replaceFirst('Exception: ', '')
            : raw;
      }

      _setError(errorMessage);

      if (context.mounted) {
        CookieToast.show(context, message: errorMessage, type: ToastType.error);
      }
    }
  }

  void togglePasswordVisibility() {
    showPassword = !showPassword;
    notifyListeners();
  }

  void clearError() {
    _error = '';
    _setState(StateManager.initial);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<bool> _validateLogin() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      _setError('Por favor, preencha todos os campos.');
      return false;
    }

    if (!_isValidateEmail(emailController.text)) {
      _setError('Por favor, digite um email válido.');
      return false;
    }
    return true;
  }

  bool _isValidateEmail(String email) =>
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
}
