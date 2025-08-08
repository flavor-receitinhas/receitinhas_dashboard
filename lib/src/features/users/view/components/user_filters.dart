import 'package:flutter/material.dart';

class UserFiltersComponent extends StatefulWidget {
  final void Function(String) onSearch;
  const UserFiltersComponent({super.key, required this.onSearch});

  @override
  State<UserFiltersComponent> createState() => _UserFiltersComponentState();
}

class _UserFiltersComponentState extends State<UserFiltersComponent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: TextField(
                onChanged: (widget.onSearch),
                decoration: InputDecoration(
                  hintText: 'Buscar usuários...',
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
