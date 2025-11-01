import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/values.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    super.key,
    this.color,
    required this.title,
    this.allowPop = false,
    this.actionIcon,
    this.onClickAction,
  });

  final Color? color;
  final String title;
  final bool allowPop;
  final IconData? actionIcon;
  final void Function()? onClickAction;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 15.h, bottom: 25.h),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: Values.horizontalPadding,
      ),
      child: Row(
        children: [
          allowPop
              ? Padding(
                  padding: EdgeInsetsDirectional.only(end: 10.w),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                )
              : SizedBox.shrink(),
          Text(
            title,
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
          ),
          Spacer(),
          actionIcon != null
              ? IconButton(onPressed: onClickAction, icon: Icon(actionIcon))
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
