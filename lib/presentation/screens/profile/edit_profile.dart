import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tasks/core/extensions/context_extensions.dart';
import 'package:my_tasks/presentation/screens/profile/widgets/edit_image.dart';

import '../../../core/routes/names.dart';
import '../../../core/utils/validators.dart';
import '../../../core/values/values.dart';
import '../../widgets/default_app_bar.dart';
import '../../widgets/my_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _nameControllle = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultAppBar(
                  title: context.localization.editProfile,
                  allowPop: true,
                  actionIcon: Icons.done,
                  onClickAction: () {
                    Navigator.pushReplacementNamed(context, AppRoutes.profile);
                  },
                ),
                EditImage(),
                SizedBox(height: 25.h),
                MyTextField(
                  controller: _nameControllle,
                  text: context.localization.name,
                  textType: TextInputType.name,
                  iconName: Icons.person,
                  hintText: context.localization.name,
                  validator: (value) {
                    return Validators.validateNotEmpty(context, value, 'error');
                  },
                ),
                MyTextField(
                  controller: _phoneController,
                  text: context.localization.phoneNumber,
                  textType: TextInputType.phone,
                  iconName: Icons.phone,
                  hintText: context.localization.phoneNumber,
                  validator: (value) {
                    return Validators.validateNotEmpty(context, value, 'error');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
