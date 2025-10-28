import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.title, this.trailing, this.onTap});

  final String title;
  final Widget? trailing;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          title: Text(title),
          trailing: trailing ?? Icon(Icons.arrow_forward_ios_rounded),
        ),
        Divider(),
      ],
    );
  }
}
