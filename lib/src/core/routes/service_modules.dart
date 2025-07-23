import 'dart:developer';

import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/routes/register_module.dart';
import 'package:dash_receitas/src/features/auth/auth_module.dart';
import 'package:dash_receitas/src/features/auth/presenter/ui/pages/login_page.dart';
import 'package:dash_receitas/src/features/home/home_module.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/pages/HOME_page.dart';
import 'package:dash_receitas/src/features/splash/presenter/ui/pages/splash_page.dart';
import 'package:dash_receitas/src/features/splash/splash_module.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ServiceModules extends ChangeNotifier {
  factory ServiceModules() {
    return _singleton;
  }

  static final ServiceModules _singleton = ServiceModules._internal();

  ServiceModules._internal();

  static ServiceModules get of => ServiceModules();
  bool isInicialize = false;
  String? _organization;
  String? requestedRouteBeforeAuth;

  set organization(String? value) {
    if (_organization != value) {
      _organization = value;
      notifyListeners();
    }
  }

  String? get organization => _organization;
  String? initalRoute;

  final List<RouteBase> _routes = [];

  final List<RegisterModule> _modules = [
    SplashModule(),
    HomeModule(),
    AuthModule(),
  ];

  late final GoRouter _router;
  Future<bool> initialise() async {
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

  String? _guard(BuildContext context, GoRouterState state) {
    log('============= route: ${state.uri.path}', name: 'Guard');
    final route = state.uri.path;
    final noRedirect = [SplashPage.route, LoginPage.route];

    if (!isInicialize && route != SplashPage.route) {
      if (!noRedirect.contains(route)) {
        initalRoute = state.uri.toString();
      }
      log('============= redirect1: ${SplashPage.route}', name: 'Guard');
      return SplashPage.route;
    }
    if (noRedirect.contains(route)) {
      return null;
    }
    if (Global.token.isEmpty && route != LoginPage.route) {
      requestedRouteBeforeAuth = route;
      log('============= redirect2: ${LoginPage.route}', name: 'Guard');
      return LoginPage.route;
    }
    if (Global.token.isNotEmpty && route == LoginPage.route) {
      log('============= redirect3: ${HomePage.route}', name: 'Guard');
      initalRoute = null;
      return HomePage.route;
    }
    if (initalRoute != null && Global.token.isNotEmpty) {
      final route = initalRoute;
      log('============= redirect4: $route', name: 'Guard');
      initalRoute = null;
      return route;
    }
    return null;
  }

  GoRouter get routers => _router;
}
