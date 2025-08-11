import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDisable;
  final VoidCallback? onActive;
  final VoidCallback? onDelete;

  const CustomPopupMenu({
    super.key,
    this.onEdit,
    this.onDisable,
    this.onDelete,
    this.onActive,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      if (onEdit != null)
        _MenuItemData(
          value: 'editar',
          icon: Icons.edit,
          label: 'Editar',
          onTap: onEdit!,
        ),
      if (onDisable != null)
        _MenuItemData(
          value: 'desativar',
          icon: Icons.block,
          label: 'Desativar',
          onTap: onDisable!,
        ),
      if (onActive != null)
        _MenuItemData(
          value: 'ativar',
          icon: Icons.check,
          label: 'Ativar',
          onTap: onActive!,
        ),
      if (onDelete != null)
        _MenuItemData(
          value: 'excluir',
          icon: Icons.delete,
          label: 'Excluir',
          color: Colors.red,
          onTap: onDelete!,
        ),
    ];

    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, color: Colors.grey.shade600),
      itemBuilder: (context) => actions.map((a) {
        return PopupMenuItem<String>(
          value: a.value,
          child: Row(
            children: [
              Icon(a.icon, size: 18, color: a.color),
              const SizedBox(width: 8),
              CookieText(text: a.label, color: a.color),
            ],
          ),
        );
      }).toList(),
      onSelected: (value) {
        actions.firstWhere((a) => a.value == value).onTap();
      },
    );
  }
}

class _MenuItemData {
  final String value;
  final IconData icon;
  final String label;
  final Color? color;
  final VoidCallback onTap;

  _MenuItemData({
    required this.value,
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });
}
