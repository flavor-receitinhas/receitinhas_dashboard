import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/global/state_manager.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/components/desktop_sidebar.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/components/top_bar.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/pages/home_page.dart';
import 'package:dash_receitas/src/features/users/view/users_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavigationItem {
  final IconsSvgEnum icon;
  final String label;
  final String route;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}

class DashboardTemplate extends StatefulWidget {
  final Widget child;
  final String title;
  final String currentRoute;

  const DashboardTemplate({
    super.key,
    required this.child,
    required this.title,
    required this.currentRoute,
  });

  @override
  State<DashboardTemplate> createState() => _DashboardTemplateState();
}

class _DashboardTemplateState extends State<DashboardTemplate>
    with TickerProviderStateMixin {
  bool _isDrawerOpen = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late AnimationController _logoAnimationController;
  late AnimationController _fadeController;
  late Animation<double> _logoRotation;
  late Animation<double> _fadeAnimation;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      icon: IconsSvgEnum.home,
      label: 'Dashboard',
      route: HomePage.route,
    ),
    NavigationItem(
      icon: IconsSvgEnum.favorite,
      label: 'Receitas',
      route: '/receitas',
      /// TODO: Implementar página de receitas
    ),
    NavigationItem(
      icon: IconsSvgEnum.persons,
      label: 'Usuários',
      route: UsersPage.route,
    ),
    NavigationItem(
      icon: IconsSvgEnum.settings,
      label: 'Configurações',
      route: '/configuracoes',
      ///TODO: Implementar página de configurações
    ),
  ];

  @override
  void initState() {
    super.initState();

    // Inicializar animações
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _logoRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    // Iniciar animações
    _logoAnimationController.forward();
    _fadeController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (MediaQuery.of(context).size.width >= 1024) {
        setState(() {
          _isDrawerOpen = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  void _navigateToRoute(String route) {
    if (widget.currentRoute != route) {
      context.go(route);
    }
  }

  bool _isRouteSelected(String route) {
    return widget.currentRoute == route;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1024;
    // final isMobile = MediaQuery.of(context).size.width < 768;

    return CookiePage(
      state: StateManager.success,
      error: '',
      errorReload: () {},
      done: () {
        if (isDesktop) {
          return Scaffold(
            key: _scaffoldKey,

            body: Row(
              children: [
                DesktopSidebar(
                  isDrawerOpen: _isDrawerOpen,
                  fadeAnimation: _fadeAnimation,
                  navigationItems: _navigationItems,
                  isRouteSelected: _isRouteSelected,
                  logoRotation: _logoRotation,
                  navigateToRoute: _navigateToRoute,
                ),
                Expanded(
                  child: Column(
                    children: [
                      TopBar(
                        onMenuTap: () {
                          setState(() {
                            _isDrawerOpen = !_isDrawerOpen;
                          });
                        },
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            key: _scaffoldKey,

            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight + 10),
              child: TopBar(
                onMenuTap: () {
                  setState(() {
                    _isDrawerOpen = !_isDrawerOpen;
                  });
                },
              ),
            ),
            drawer: Drawer(
              backgroundColor: Theme.of(context).colorScheme.surface,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(
                            context,
                          ).colorScheme.primary.withValues(alpha: 0.8),
                        ],
                      ),
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Image.asset(
                            ImagesEnum.logo.path,
                            height: 32,
                            width: 32,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CookieText(
                                text: 'Dash Receitas',
                                typography: CookieTypography.title,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                              CookieText(
                                text: 'Gerenciamento de receitas',
                                typography: CookieTypography.tiny,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onPrimary.withValues(alpha: 0.8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      itemCount: _navigationItems.length,
                      itemBuilder: (context, index) {
                        final item = _navigationItems[index];
                        final isSelected = _isRouteSelected(item.route);

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: CookieSvg(
                                svg: item.icon,
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onSurface
                                          .withValues(alpha: 0.7),
                              ),
                            ),
                            title: CookieText(
                              text: item.label,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                              typography: isSelected
                                  ? CookieTypography.button
                                  : CookieTypography.body,
                            ),
                            selected: isSelected,
                            selectedTileColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.05),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            onTap: () {
                              _navigateToRoute(item.route);
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            body: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: widget.child,
              ),
            ),
          );
        }
      },
    );
  }
}
