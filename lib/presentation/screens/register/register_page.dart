import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/extensions/context_extensions.dart';
import '../../../domain/entities/user_entity.dart';

import '../../../core/routes/names.dart';
import '../../../core/utils/validators.dart';
import '../../../core/values/values.dart';
import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../widgets/my_button.dart';
import '../../widgets/my_text_field.dart';
import '../login/widgets/head_content.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        RegisterRequested(
          user: UserEntity(
            email: _emailController.text.trim(),
            name: _nameController.text.trim(),
          ),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Values.horizontalPadding),
            child: Stack(
              children: [
                Positioned.fill(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset(
                      "assets/images/next-tasks.svg",
                      semanticsLabel: 'Login image',
                      width: 335.w,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeadContent(
                          title: context.localization.welcome,
                          description: context.localization.registerDescription,
                        ),
                        SizedBox(height: 40.h),
                        // LightText("Email"),
                        // SizedBox(height: 5.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              MyTextField(
                                controller: _nameController,
                                text: context.localization.name,
                                textType: TextInputType.name,
                                iconName: Icons.person,
                                hintText: context.localization.enterName,
                                validator: (value) {
                                  return Validators.validateFullName(
                                    context,
                                    value,
                                  );
                                },
                              ),
                              MyTextField(
                                controller: _emailController,
                                text: context.localization.email,
                                textType: TextInputType.emailAddress,
                                iconName: Icons.email,
                                hintText: context.localization.enterEmail,
                                validator: (value) {
                                  return Validators.validateEmail(
                                    context,
                                    value,
                                  );
                                },
                              ),
                              // LightText("Password"),
                              // SizedBox(height: 5.h),
                              MyTextField(
                                controller: _passwordController,
                                text: context.localization.password,
                                textType: TextInputType.visiblePassword,
                                iconName: Icons.lock,
                                hintText: context.localization.enterPassword,
                                validator: (value) {
                                  return Validators.validatePasswordForLogin(
                                    context,
                                    value,
                                  );
                                },
                              ),
                              SizedBox(height: 5.h),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Not a member?",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                    children: [
                                      TextSpan(
                                        text: context.localization.loginNow,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => Navigator.pushNamed(
                                            context,
                                            AppRoutes.signup,
                                          ),
                                        style: TextStyle(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.h),
                              BlocBuilder<AuthBloc, AuthState>(
                                builder: (context, state) {
                                  if (state is AuthLoading) {
                                    return Center(
                                      child:
                                          CircularProgressIndicator.adaptive(),
                                    );
                                  }
                                  return MyButton(
                                    onTap: _onRegisterPressed,
                                    btnType: ButtonType.primary,
                                    text: state is! AuthLoading
                                        ? context.localization.register
                                        : null,
                                    child: state is AuthLoading
                                        ? Center(
                                            child:
                                                CircularProgressIndicator.adaptive(),
                                          )
                                        : null,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
