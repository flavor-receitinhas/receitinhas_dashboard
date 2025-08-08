import 'dart:developer';

import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/sembast_database.dart';
import 'package:dash_receitas/src/core/services/preference/sembast/store_sembast_enum.dart';
import 'package:dash_receitas/src/core/services/preference/user_preference/key_preference.dart';
import 'package:dash_receitas/src/features/auth/auth_module.dart';
import 'package:dash_receitas/src/features/auth/domain/entities/user_entity.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';
import 'package:dash_receitas/src/features/home/home_module.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/pages/HOME_page.dart';
import 'package:dash_receitas/src/features/splash/presenter/ui/pages/splash_page.dart';
import 'package:dash_receitas/src/features/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceModules extends ChangeNotifier {
  factory ServiceModules() => _singleton;

  static final ServiceModules _singleton = ServiceModules._internal();

  ServiceModules._internal();

  static ServiceModules get of => ServiceModules();

  bool isInicialize = false;
  String? _organization;

  /// Armazena a rota solicitada antes da autenticação para redirecionamento posterior
  String? requestedRouteBeforeAuth;

  /// Armazena a rota inicial solicitada durante a inicialização do app
  String? initalRoute;

  set organization(String? value) {
    if (_organization != value) {
      _organization = value;
      notifyListeners();
    }
  }

  String? get organization => _organization;

  final List<RouteBase> _routes = [];

  final List<RegisterModule> _modules = [
    SplashModule(),
    HomeModule(),
    AuthModule(),
  ];

  late final GoRouter _router;

  Future<bool> initialise() async {
    final pref = di<PersistentDatabaseSembast>();

    final sessionJson = await pref.get(
      id: KeyPreferences.userSession.name,
      store: StoreSembastEnum.user,
    );
    if (sessionJson != null) {
      final session = UserEntity.fromJson(sessionJson);
      Global.user = session;
    }

    isInicialize = true;
    return true;
  }

  void register() {
    for (final module in _modules) {
      module.inicialize();
      _routes.addAll(module.routes());
    }

    _router = GoRouter(
      redirect: _guard,
      routes: _routes,
      errorBuilder: (context, state) => const SizedBox(),
    );
  }

  /// Método de guarda de rotas que controla o acesso e redirecionamentos
  ///
  /// Verifica em ordem:
  /// 1. Se o app foi inicializado
  /// 2. Se a rota é pública (não requer verificações)
  /// 3. Se o usuário está autenticado para rotas protegidas
  /// 4. Se há uma rota inicial aguardando redirecionamento
  ///
  /// Retorna a rota para redirecionamento ou null se não há redirecionamento necessário
  String? _guard(BuildContext context, GoRouterState state) {
    final currentRoute = state.uri.path;
    final currentUri = state.uri.toString();
    final isAuthenticated = Global.user != null;

    log('Evaluating route: $currentRoute', name: 'RouteGuard');

    // 1. Verificar se o app foi inicializado
    final initializationRedirect = _handleInitializationRedirect(
      currentRoute,
      currentUri,
    );
    if (initializationRedirect != null) return initializationRedirect;

    // 2. Permitir acesso às rotas que não requerem verificação
    if (_isPublicRoute(currentRoute)) return null;

    // 3. Verificar autenticação
    final authRedirect = _handleAuthenticationRedirect(
      currentRoute,
      currentUri,
      isAuthenticated,
    );
    if (authRedirect != null) return authRedirect;

    // 4. Lidar com rota inicial após autenticação
    final initialRouteRedirect = _handleInitialRouteRedirect(isAuthenticated);
    if (initialRouteRedirect != null) return initialRouteRedirect;

    // Nenhum redirecionamento necessário
    return null;
  }

  /// Verifica se o app foi inicializado e redireciona para splash se necessário
  String? _handleInitializationRedirect(
    String currentRoute,
    String currentUri,
  ) {
    if (!isInicialize && currentRoute != SplashPage.route) {
      // Salva a rota solicitada para redirecionamento posterior
      if (!_isPublicRoute(currentRoute)) {
        initalRoute = currentUri;
      }
      log(
        'Redirecting to splash (app not initialized): ${SplashPage.route}',
        name: 'RouteGuard',
      );
      return SplashPage.route;
    }
    return null;
  }

  /// Verifica se a rota é pública (não requer autenticação ou verificações especiais)
  bool _isPublicRoute(String route) {
    final publicRoutes = [SplashPage.route, LoginPage.route];
    return publicRoutes.contains(route);
  }

  /// Lida com redirecionamentos relacionados à autenticação
  String? _handleAuthenticationRedirect(
    String currentRoute,
    String currentUri,
    bool isAuthenticated,
  ) {
    // Usuário não autenticado tentando acessar rota protegida
    if (!isAuthenticated && currentRoute != LoginPage.route) {
      requestedRouteBeforeAuth = currentUri;
      log(
        'Redirecting unauthenticated user to login: ${LoginPage.route}',
        name: 'RouteGuard',
      );
      return LoginPage.route;
    }

    // Usuário autenticado tentando acessar página de login
    if (isAuthenticated && currentRoute == LoginPage.route) {
      initalRoute = null;
      log(
        'Redirecting authenticated user to home: ${HomePage.route}',
        name: 'RouteGuard',
      );
      return HomePage.route;
    }

    return null;
  }

  /// Lida com redirecionamento para rota inicial após autenticação
  String? _handleInitialRouteRedirect(bool isAuthenticated) {
    if (isAuthenticated && initalRoute != null) {
      final targetRoute = initalRoute!;
      initalRoute = null;
      log('Redirecting to initial route: $targetRoute', name: 'RouteGuard');
      return targetRoute;
    }
    return null;
  }

  GoRouter get routers => _router;
}
