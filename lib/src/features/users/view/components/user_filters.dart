import 'package:flutter/material.dart';

class DefaultPageFiltersComponent extends StatefulWidget {
  final String title;
  final void Function(String) onSearch;
  final void Function()? onClearSearch;
  const DefaultPageFiltersComponent({
    super.key,
    required this.onSearch,
    required this.title,
    this.onClearSearch,
  });

  @override
  State<DefaultPageFiltersComponent> createState() =>
      _DefaultPageFiltersComponentState();
}

class _DefaultPageFiltersComponentState
    extends State<DefaultPageFiltersComponent> {
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
                  hintText: widget.title,
                  prefixIcon: Icon(Icons.search, color: Colors.grey.shade600),
                  suffixIcon: widget.onClearSearch != null
                      ? IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey.shade600),
                          onPressed: widget.onClearSearch,
                        )
                      : null,
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
