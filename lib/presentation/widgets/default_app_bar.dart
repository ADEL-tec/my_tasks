import 'package:flutter/material.dart';

import '../../core/values/values.dart';

class DefaultAppBar extends StatelessWidget {
  const DefaultAppBar({super.key, this.color, required this.title});

  final Color? color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: color),
            ),
          ),
          Image.asset("assets/images/icon.png", height: 70),
        ],
      ),
    );
  }
}
