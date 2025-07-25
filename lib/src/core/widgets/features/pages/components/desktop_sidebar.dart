import 'package:dash_receitas/src/core/global/assets_enum.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_dash_template.dart';
import 'package:flutter/material.dart';

class DesktopSidebar extends StatelessWidget {
  final bool isDrawerOpen;
  final Animation<double> logoRotation;
  final Animation<double> fadeAnimation;
  final List<NavigationItem> navigationItems;
  final Function(String) navigateToRoute;
  final bool Function(String) isRouteSelected;
  const DesktopSidebar({
    super.key,
    required this.isDrawerOpen,
    required this.logoRotation,
    required this.fadeAnimation,
    required this.navigationItems,
    required this.navigateToRoute,
    required this.isRouteSelected,
  });
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 0),
      curve: Curves.easeInOutCubic,
      width: isDrawerOpen ? 280 : 95,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.95),
            ],
          ),
          border: Border(
            right: BorderSide(
              color: Theme.of(context).dividerColor.withValues(alpha: 0.08),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: kToolbarHeight + 20,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  AnimatedBuilder(
                    animation: logoRotation,
                    builder: (context, child) {
                      return Transform.rotate(
                        angle: logoRotation.value * 6.28,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Image.asset(
                            ImagesEnum.logo.path,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      );
                    },
                  ),
                  if (isDrawerOpen) ...[
                    const SizedBox(width: 16),
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: CookieText(
                        text: 'Dash Receitas',
                        typography: CookieTypography.title,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            if (isDrawerOpen)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.3),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                itemCount: navigationItems.length,
                itemBuilder: (context, index) {
                  final item = navigationItems[index];
                  final isSelected = isRouteSelected(item.route);

                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300 + (index * 50)),
                    curve: Curves.easeOutBack,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => navigateToRoute(item.route),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.15),
                                      Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.05),
                                    ],
                                  )
                                : null,
                            borderRadius: BorderRadius.circular(16),
                            border: isSelected
                                ? Border.all(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.2),
                                    width: 1,
                                  )
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .withValues(alpha: 0.1),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ]
                                : null,
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
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
                                  height: 20,
                                  color: isSelected
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context).colorScheme.onSurface
                                            .withValues(alpha: 0.7),
                                ),
                              ),
                              if (isDrawerOpen) ...[
                                const SizedBox(width: 16),
                                Expanded(
                                  child: CookieText(
                                    text: item.label,
                                    isSelect: false,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                    typography: isSelected
                                        ? CookieTypography.button
                                        : CookieTypography.body,
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
