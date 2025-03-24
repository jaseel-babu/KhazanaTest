import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazana_fintech_task/core/common/widgets/custom_text_field.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_routes.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';
import 'package:khazana_fintech_task/core/utils/show_snackbar.dart';
import 'package:khazana_fintech_task/core/utils/validation_mixins/validation_mixin.dart';
import 'package:khazana_fintech_task/features/auth/presentation/bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with ValidationMixin {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailureState) {
              showSnackBar(context, state.message);
            }
            if (state is AuthSuccessState) {
              context.read<AuthBloc>().add(AuthCheckRequested());
            }
            if (state is AuthAuthenticated) {
              if (state.user.userName != null) {
                Navigator.pushReplacementNamed(context, AppRoutes.homePage);
              }
            }
          },
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome back',
                    style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        color: Color.fromARGB(255, 187, 187, 187)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      validator: validateEmail,
                      controller: emailController,
                      insidelabel: "Enter your email"),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      validator: validatePassword,
                      controller: passwordController,
                      insidelabel: "Enter your password"),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthSignInEvent(
                                      email: emailController.text.trim(),
                                      password: passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryBlueColor,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 40,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: AppColor.borderColor,
                              ),
                            ),
                          ),
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                              fontSize: 15,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w500,
                              color: AppColor.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.signupPage);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: const Color.fromARGB(255, 126, 122, 122),
                            ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppColor.whiteColor,
                                    fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
