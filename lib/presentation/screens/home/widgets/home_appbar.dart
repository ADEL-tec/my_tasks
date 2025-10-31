import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/extensions/context_extensions.dart';

import '../../../../core/values/values.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 15.h),
      padding: EdgeInsetsDirectional.symmetric(
        horizontal: Values.horizontalPadding,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "${context.localization.hello}, $name",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          // Image.asset("assets/images/icon.png", height: 70),
        ],
      ),
    );
  }
}
