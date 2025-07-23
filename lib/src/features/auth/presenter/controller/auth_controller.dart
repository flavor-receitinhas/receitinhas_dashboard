import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_serivce.dart';
import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService;

  AuthController(this._authService);

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

  Future<void> login() async {
    try {
      _setState(StateManager.loading);

      await _authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      _setState(StateManager.success);
    } catch (e) {
      _setError(e.toString());
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
}
