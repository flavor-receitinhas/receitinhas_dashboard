import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/components/user_provider_stat.dart';
import 'package:dash_receitas/src/features/home/presenter/ui/components/user_stat_item.dart';
import 'package:dash_receitas/src/features/users/domain/entity/users_entity.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final int activeUsers;
  final int inactiveUsers;
  final int emailVerifiedUsers;
  final List<UsersEntity> users;
  final ThemeData theme;

  const UserCard({
    super.key,
    required this.activeUsers,
    required this.inactiveUsers,
    required this.emailVerifiedUsers,
    required this.theme,
    required this.users,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buildProviderStats(ThemeData theme) {
      final providerCounts = <String, int>{};
      for (final u in users) {
        providerCounts[u.signProvider] =
            (providerCounts[u.signProvider] ?? 0) + 1;
      }

      return providerCounts.entries
          .map(
            (entry) => ProviderStatItem(
              provider: entry.key,
              count: entry.value,
              theme: theme,
            ),
          )
          .toList();
    }

    return Column(
      children: [
        UserStatItem(
          label: 'Usuários Ativos',
          value: activeUsers,
          color: Colors.green,
          theme: theme,
        ),
        const SizedBox(height: 12),
        UserStatItem(
          label: 'Usuários Inativos',
          value: inactiveUsers,
          color: Colors.red,
          theme: theme,
        ),
        const SizedBox(height: 12),
        UserStatItem(
          label: 'E-mails Verificados',
          value: emailVerifiedUsers,
          color: Colors.blue,
          theme: theme,
        ),
        const SizedBox(height: 20),
        if (users.isNotEmpty) ...[
          CookieText(
            text: 'Provedores de Login',
            typography: CookieTypography.tiny,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 8),
          ...buildProviderStats(theme),
        ],
      ],
    );
  }
}
