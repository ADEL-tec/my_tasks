import 'package:flutter/material.dart';

class SettingsDropdown<T> extends StatelessWidget {
  final String label;
  final T value;
  final List<T> options;
  final IconData? Function(T value)? iconBuilder;
  final String Function(T value) textBuilder;
  final ValueChanged<T?> onChanged;

  const SettingsDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.textBuilder,
    required this.onChanged,
    this.iconBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<T>(
            value: value,
            items: options
                .map(
                  (item) => DropdownMenuItem<T>(
                    value: item,
                    child: Row(
                      children: [
                        if (iconBuilder != null && iconBuilder!(item) != null)
                          Icon(
                            iconBuilder!(item),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        if (iconBuilder != null) const SizedBox(width: 10),
                        Text(
                          textBuilder(item),
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1.5,
                ),
              ),
            ),
            dropdownColor: Theme.of(context).colorScheme.surface,
          ),
        ],
      ),
    );
  }
}
