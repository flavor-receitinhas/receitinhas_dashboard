import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_dash_template.dart';
import 'package:dash_receitas/src/features/users/view/components/user_filters.dart';
import 'package:dash_receitas/src/features/users/view/components/users_empty.dart';
import 'package:dash_receitas/src/features/users/view/components/users_header.dart';
import 'package:flutter/material.dart';

class DefaultPageEntity {
  final String title;
  final String? description;
  final List<dynamic> data;
  bool isDisabledUser;

  DefaultPageEntity({
    required this.title,
    required this.data,
    this.description,
    this.isDisabledUser = false,
  });
}

class CookieDefaultPage extends StatefulWidget {
  final String headerTitle;
  final String headerDescription;
  final String searchHint;
  final void Function(String) onSearch;
  final String currentRoute;
  final String pageTitle;
  final List<DefaultPageEntity> data;
  final Widget Function(int index)? popMenu;

  const CookieDefaultPage({
    super.key,
    required this.currentRoute,
    required this.data,
    required this.pageTitle,
    required this.onSearch,
    required this.headerTitle,
    required this.headerDescription,
    this.searchHint = 'Buscar...',
    this.popMenu,
  });

  @override
  State<CookieDefaultPage> createState() => _CookieDefaultPageState();
}

class _CookieDefaultPageState extends State<CookieDefaultPage> {
  @override
  Widget build(BuildContext context) {
    return DashboardTemplate(
      title: widget.pageTitle,
      currentRoute: widget.currentRoute,
      child: Column(
        children: [
          DefaultPageHeaderComponent(
            data: widget.data,
            title: widget.headerTitle,
            description: widget.headerDescription,
            typeOfData: widget.pageTitle,
          ),
          DefaultPageFiltersComponent(
            title: widget.searchHint,
            onSearch: widget.onSearch,
          ),
          widget.data.isEmpty
              ? const UsersEmptyComponent()
              : Expanded(
                  child: ListView.builder(
                    itemCount: widget.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.grey.shade200,
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.03),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.yellow.shade400,
                              child: Center(
                                child: CookieText(
                                  text: widget.data[index].title[0]
                                      .toUpperCase(),
                                  typography: CookieTypography.title,
                                  isSelect: false,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CookieText(
                                        text: widget.data[index].title,
                                        typography: CookieTypography.body,
                                        color: Colors.grey.shade600,
                                      ),
                                      if (widget
                                          .data[index]
                                          .isDisabledUser) ...[
                                        const SizedBox(width: 8),
                                        Icon(
                                          Icons.circle,
                                          size: 8,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 8),
                                        CookieText(
                                          text: 'Inativo',
                                          color: Colors.red,
                                        ),
                                      ],
                                    ],
                                  ),
                                  const SizedBox(height: 4),

                                  if (widget.data[index].description !=
                                      null) ...[
                                    const SizedBox(height: 4),
                                    CookieText(
                                      text: widget.data[index].description!,
                                      color: Colors.grey,
                                      typography: CookieTypography.tiny,
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            if (widget.popMenu != null) widget.popMenu!(index),
                          ],
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
