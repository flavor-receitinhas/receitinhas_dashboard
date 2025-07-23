import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/sembast_database.dart';
import 'package:dash_receitas/src/features/auth/domain/services/auth_serivce.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';

import 'package:flutter/material.dart';

class SplashController extends ChangeNotifier {
  final AuthService _authService;

  SplashController(this._authService);

  String route = LoginPage.route;

  Future<void> init() async {
    await loadDependences();
    notifyListeners();
  }

  Future<void> loadDependences() async {
    await di.get<PersistentDatabaseSembast>().starting();
    if (await _authService.isLogged()) {
      await _authService.refreshToken(forceRefresh: true);
    }
  }
}
