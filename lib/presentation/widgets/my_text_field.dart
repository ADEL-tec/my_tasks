import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final TextInputType textType;
  final IconData iconName;
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.text,
    required this.controller,
    required this.textType,
    required this.iconName,
    required this.hintText,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      padding: EdgeInsets.only(left: 16.w, right: 10.w),
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.w),
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
