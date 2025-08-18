import 'package:dash_receitas/src/core/global/global_variables.dart';
import 'package:dash_receitas/src/core/widgets/features/pages/cookie_default_page.dart';
import 'package:dash_receitas/src/features/ingredients/view/components/custom_pop_menu.dart';
import 'package:dash_receitas/src/features/users/controllers/users_controller.dart';
import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:dash_receitas/src/features/users/view/edit_role.dart';
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
        onEdit: () => showEditUserRoleDialog(
          context,
          currentRole: Roles.fromString(ct.users[i].role),
          onRoleChanged: (s) async {
            await ct.editRole(
              users[i].id,
              RoleEntity(id: s.name, userId: users[i].id, role: s),
              i,
            );
            setState(() {});
          },
        ),
      ),
      currentRoute: UsersPage.route,
      data: users
          .map( 
            (e) => DefaultPageEntity(
              title: e.email,
              data: [e],
              description: 'Criado em ${ct.formatUserDateTime(e.createdAt)}',
              isDisabledUser: e.disabled,
              role: Roles.fromString(e.role),
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
