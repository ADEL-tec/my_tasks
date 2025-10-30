import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/values.dart';

enum ButtonType { primary, secondary }

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.btnType,
    required this.text,
    this.onTap,
    this.child,
    this.icon,
  });

  final ButtonType btnType;

  /// if {text} is not NULL, {child} shoold be null
  final String? text;

  /// if {child} is not NULL, {text} shoold be null
  final Widget? child;

  final IconData? icon;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.h,
        margin: EdgeInsets.only(top: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: btnType == ButtonType.primary
              ? Theme.of(context).colorScheme.tertiary
              : Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(Values.buttonRadius),
          // border: btnType == AuthType.register
          //     ? Border.all(color: AppColors.primaryThreeElementText)
          //     : null,
          // boxShadow: [
          //   BoxShadow(
          //     spreadRadius: 1,
          //     blurRadius: 2,
          //     offset: Offset(0, 1),
          //     color: Colors.grey.withAlpha(90),
          //   ),
          // ],
        ),
        child: Center(
          child:
              child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon != null
                      ? Icon(
                          icon,
                          color: btnType == ButtonType.primary
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context).colorScheme.tertiary,
                        )
                      : SizedBox.shrink(),
                  SizedBox(width: 8.w),
                  Text(
                    text!,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: btnType == ButtonType.primary
                          ? Theme.of(context).colorScheme.tertiaryContainer
                          : Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
