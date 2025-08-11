import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_default_page.dart';
import 'package:dash_receitas/src/features/ingredients/view/components/custom_pop_menu.dart';
import 'package:dash_receitas/src/features/users/controllers/users_controller.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  static const String route = '/users';
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final ct = di<UsersController>();
  @override
  void initState() {
    super.initState();
    ct.addListener(() {
      setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ct.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final users = ct.users;
    return CookieDefaultPage(
      popMenu: (i) => CustomPopupMenu(
        onDisable: !ct.users[i].disabled
            ? () async {
                await ct.disableUser(i);
                setState(() {});
              }
            : null,
        onActive: ct.users[i].disabled
            ? () async {
                await ct.activeUser(i);
                setState(() {});
              }
            : null,
      ),
      currentRoute: UsersPage.route,
      data: users
          .map(
            (e) => DefaultPageEntity(
              title: e.email,
              data: [e],
              description: 'Criado em ${ct.formatUserDateTime(e.createdAt)}',
              isDisabledUser: e.disabled,
            ),
          )
          .toList(),
      pageTitle: 'Usuários',
      onSearch: (s) {
        if (s.isEmpty) {
          ct.clearSearch();
          setState(() {});
          return;
        }
        ct.searchUsers(s);
        setState(() {});
      },
      headerTitle: 'Usuários',
      headerDescription: 'Gerencie os usuários da plataforma.',
    );
  }
}
