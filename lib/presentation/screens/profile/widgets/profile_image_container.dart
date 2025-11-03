import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tasks/global.dart';

class ProfileImageContainer extends StatelessWidget {
  const ProfileImageContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final name = Global.currentUserData?.name;
    return Container(
      width: 100.h,
      height: 100.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Center(
        child: Text(
          name?.characters.first.toUpperCase() ?? "A",
          style: TextStyle(fontSize: 49.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
