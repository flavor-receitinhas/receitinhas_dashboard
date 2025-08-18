import 'package:dash_receitas/src/core/widgets/cookie_export.dart';
import 'package:dash_receitas/src/features/users/domain/entity/roles_enum.dart';
import 'package:flutter/material.dart';

class EditUserRoleDialog extends StatefulWidget {
  final Roles? currentRole;
  final Function(Roles) onRoleChanged;

  const EditUserRoleDialog({
    super.key,
    this.currentRole,
    required this.onRoleChanged,
  });

  @override
  State<EditUserRoleDialog> createState() => _EditUserRoleDialogState();
}

class _EditUserRoleDialogState extends State<EditUserRoleDialog> {
  Roles? selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.currentRole ?? Roles.common;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: CookieText(
        text: "Editar Role do Usuário",
        typography: CookieTypography.title,
        color: Colors.black87,
        isSelect: false,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...Roles.values.map(
            (role) => RadioListTile<Roles>(
              title: CookieText(
                text: role.name.toUpperCase(),
                typography: CookieTypography.body,
                color: Colors.black87,
                isSelect: false,
              ),
              value: role,
              groupValue: selectedRole,
              activeColor: Colors.amber,
              onChanged: (Roles? value) {
                setState(() {
                  selectedRole = value;
                });
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: CookieText(
            text: "CANCELAR",
            typography: CookieTypography.button,
            color: Colors.grey[600],
            isSelect: false,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedRole != null) {
              widget.onRoleChanged(selectedRole!);
              Navigator.of(context).pop();
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: CookieText(
            text: "SALVAR",
            typography: CookieTypography.button,
            color: Colors.black87,
            isSelect: false,
          ),
        ),
      ],
    );
  }
}

void showEditUserRoleDialog(
  BuildContext context, {
  Roles? currentRole,
  required Function(Roles) onRoleChanged,
}) {
  showDialog(
    context: context,
    builder: (context) => EditUserRoleDialog(
      currentRole: currentRole,
      onRoleChanged: onRoleChanged,
    ),
  );
}
