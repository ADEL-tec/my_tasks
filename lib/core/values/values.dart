import 'package:flutter_screenutil/flutter_screenutil.dart';

class Values {
  static const double iconRadius = 24;
  static double buttonRadius = 15.w;
  static const double modalBottomRadius = 26;
  static const double inputRadius = 18;
  static double horizontalPadding = 20.w;

  // SPACING
  static const double sBigSpace = 45;
  static const double sMediumSpace = 35;
  static const double sSmallSpace = 10;

  /// This regex matches:
  ///   - example@mail.com
  ///   - john.doe@barbershop.co
  ///   - a_b-c@sub.domain.net
  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
}
