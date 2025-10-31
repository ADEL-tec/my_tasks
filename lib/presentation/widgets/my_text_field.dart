import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/values/values.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType textType;
  final IconData iconName;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final int? maxLines;
  final int? minLines;

  const MyTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.textType,
    required this.iconName,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxLines != 1 ? 60.h + (15 * maxLines!) : 60.h,
      padding: EdgeInsetsDirectional.only(start: 16.w, end: 10.w),
      margin: EdgeInsetsDirectional.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Values.buttonRadius),
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      child: Row(
        children: [
          Icon(iconName, size: 18.h),
          Expanded(
            child: TextFormField(
              onChanged: onChanged,
              keyboardType: textType,
              controller: controller,
              maxLines: maxLines,
              minLines: minLines,
              obscureText: textType == TextInputType.visiblePassword
                  ? true
                  : false,
              decoration: InputDecoration(
                hintText: hintText,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.outline,
                ),
              ),
              style: TextStyle(fontSize: 12.sp),
              autocorrect: false,
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }
}
