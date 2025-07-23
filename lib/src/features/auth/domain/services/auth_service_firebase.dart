import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/features/auth/domain/entities/user_entity.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_serivce.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServiceFirebase implements AuthService {
  final _firebaseInstance = FirebaseAuth.instance;

  @override
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<UserEntity> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseInstance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserEntity(id: credential.user!.uid, email: email);
      Global.token = await credential.user!.getIdToken() ?? '';
      Global.user = user;
      return user;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseInstance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = UserEntity(id: credential.user!.uid, email: email);
      Global.token = await credential.user!.getIdToken() ?? '';
      Global.user = user;
      return user;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    try {
      await _firebaseInstance.sendPasswordResetEmail(email: email);
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<void> refreshToken({bool forceRefresh = false}) async {
    try {
      if (_firebaseInstance.currentUser == null) {
        throw Exception('User not logged in');
      }
      Global.token = (await _firebaseInstance.currentUser!.getIdToken(
        forceRefresh,
      ))!;
      Global.user = UserEntity(
        id: _firebaseInstance.currentUser!.uid,
        email: _firebaseInstance.currentUser!.email!,
      );

      if (Global.token.isEmpty) {
        throw Exception('Token is empty');
      }
    } catch (e) {
      _handleError(e);
    }
  }

  @override
  Future<bool> isLogged() async {
    try {
      final userLogged = _firebaseInstance.currentUser != null;
      return userLogged;
    } catch (e) {
      _handleError(e);
      rethrow;
    }
  }

  void _handleError(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          throw Exception('Usuário não encontrado');
        case 'wrong-password':
          throw Exception('Senha incorreta');
        case 'email-already-in-use':
          throw Exception('Email já está em uso');
        case 'invalid-email':
          throw Exception('Email inválido');
        default:
          throw Exception('Erro desconhecido: ${error.message}');
      }
    } else {
      throw Exception('Erro desconhecido: $error');
    }
  }
}
