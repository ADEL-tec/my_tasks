import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/values.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.count, required this.title});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: Values.horizontalPadding,
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 12.w),
            padding: EdgeInsetsDirectional.symmetric(
              horizontal: 12.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.w),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
            child: Text(
              count.toString(),
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
