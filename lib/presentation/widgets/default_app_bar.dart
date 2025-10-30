import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/values/values.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({
    super.key,
    this.color,
    required this.title,
    this.allowPop = false,
  });

  final Color? color;
  final String title;
  final bool allowPop;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h, bottom: 25.h),
      padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
      child: Row(
        children: [
          allowPop
              ? Padding(
                  padding: EdgeInsets.only(right: 10.w),
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
        ],
      ),
    );
  }
}
