import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_tasks/core/extensions/context_extensions.dart';
import 'package:my_tasks/core/routes/routes.dart';
import 'package:my_tasks/core/utils/validators.dart';
import 'package:my_tasks/presentation/screens/login/widgets/head_content.dart';
import 'package:my_tasks/presentation/widgets/my_button.dart';

import '../../../core/values/values.dart';
import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../widgets/my_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    print("email ${_emailController.text}");
    print("password ${_passwordController.text}");
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
        LoginRequested(
          email: _emailController.text.trim(),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadContent(),
                      SizedBox(height: 40.h),
                      // LightText("Email"),
                      // SizedBox(height: 5.h),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            MyTextField(
                              controller: _emailController,
                              text: context.localization.email,
                              textType: TextInputType.emailAddress,
                              iconName: Icons.email,
                              hintText: context.localization.enterEmail,
                              validator: (value) {
                                return Validators.validateEmail(context, value);
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
                            BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                if (state is AuthLoading) {
                                  return Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  );
                                }
                                return MyButton(
                                  onTap: _onLoginPressed,
                                  btnType: ButtonType.primary,
                                  text: state is! AuthLoading
                                      ? context.localization.login
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
