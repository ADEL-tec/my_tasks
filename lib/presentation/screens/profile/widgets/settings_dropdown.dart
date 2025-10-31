import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/values.dart';

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
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.symmetric(vertical: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: Theme.of(
          //     context,
          //   ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 8.h),
          DropdownButtonFormField<T>(
            key: ValueKey(Localizations.localeOf(context).languageCode),
            value: value,
            borderRadius: BorderRadius.circular(Values.buttonRadius),
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
                        if (iconBuilder != null) SizedBox(width: 10.w),
                        Text(
                          textBuilder(item),
                          style: TextStyle(fontSize: 16.sp),
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
                borderRadius: BorderRadius.circular(Values.buttonRadius),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Values.buttonRadius),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Values.buttonRadius),
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
