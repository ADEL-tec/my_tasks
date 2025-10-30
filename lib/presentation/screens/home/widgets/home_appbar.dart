import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/values/values.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15.h),
      padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "Hello, $name",
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),
          ),
          // Image.asset("assets/images/icon.png", height: 70),
        ],
      ),
    );
  }
}
