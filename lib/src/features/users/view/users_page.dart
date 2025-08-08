import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_dash_template.dart';
import 'package:dash_receitas/src/features/users/controllers/users_controller.dart';
import 'package:dash_receitas/src/features/users/view/components/user_filters.dart';
import 'package:dash_receitas/src/features/users/view/components/users_empty.dart';
import 'package:dash_receitas/src/features/users/view/components/users_header.dart';
import 'package:flutter/material.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final ct = di<UsersController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ct.init();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ct.users;
    return DashboardTemplate(
      title: 'Usuários',
      currentRoute: '/usuarios',
      child: Column(
        children: [
          UsersHeaderComponent(users: users),
          UserFiltersComponent(
            onSearch: (searchTerm) {
              if (searchTerm.isEmpty) {
                ct.init();
                setState(() {});
                return;
              }
              ct.searchUsers(searchTerm);
              setState(() {});
            },
          ),
          users.isEmpty
              ? const UsersEmptyComponent()
              : Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
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
                                  text: users[index].email[0].toUpperCase(),
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
                                  const SizedBox(height: 4),
                                  CookieText(
                                    text: users[index].email,
                                    typography: CookieTypography.body,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(height: 8),
                                ],
                              ),
                            ),
                            const SizedBox(width: 16),
                            PopupMenuButton<String>(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.grey.shade600,
                              ),
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'editar',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 18),
                                      SizedBox(width: 8),
                                      CookieText(text: 'Editar'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'desativar',
                                  child: Row(
                                    children: [
                                      Icon(Icons.block, size: 18),
                                      SizedBox(width: 8),
                                      CookieText(text: 'Desativar'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'excluir',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 18,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 8),
                                      CookieText(
                                        text: 'Excluir',
                                        color: Colors.red,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              onSelected: (value) {
                                //TODO: Implementar ações do menu
                              },
                            ),
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
