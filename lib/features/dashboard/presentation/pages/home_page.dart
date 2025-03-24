import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_routes.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';
import 'package:khazana_fintech_task/core/utils/show_snackbar.dart';
import 'package:khazana_fintech_task/features/auth/presentation/bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Dashboard",
          style: TextStyle(color: AppColor.whiteColor),
        ),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthFailureState) {
                showSnackBar(context, state.message);
              }
              if (state is AuthUnauthenticated) {
                Navigator.pushReplacementNamed(context, AppRoutes.loginPage);
              }
            },
            builder: (context, state) {
              if (state is AuthAuthenticated) {
                return PopupMenuButton(
                  padding: const EdgeInsets.all(2),
                  color: AppColor.borderColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  onSelected: (value) {
                    if (value == 1) {
                      context.read<AuthBloc>().add(AuthUserLoggedOut());
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<int>(
                      value: 0,
                      child: Row(
                        children: [
                          Text("Hi ${state.user.userName}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.logout, color: Colors.red),
                          SizedBox(width: 5),
                          Text("Logout", style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColor.primaryBlueColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Center(
                      child: Text(
                        state.user.userName![0].toUpperCase(),
                        style: const TextStyle(
                            color: AppColor.whiteColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColor.primaryBlueColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColor.whiteColor,
                ),
              );
            },
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: const SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [SizedBox(), SizedBox()],
        ),
      ),
    );
  }
}
