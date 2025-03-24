import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_pages.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_routes.dart';
import 'package:khazana_fintech_task/core/constant/theme/theme.dart';
import 'package:khazana_fintech_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/bloc/mutualfund%20bloc/mutual_fund_bloc.dart';
import 'package:khazana_fintech_task/init_dependencies.dart';

class Khazana extends StatefulWidget {
  const Khazana({super.key});

  @override
  State<Khazana> createState() => _KhazanaState();
}

class _KhazanaState extends State<Khazana> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => serviceLocator<AuthBloc>(),
        ),        BlocProvider(
          create: (_) => serviceLocator<MutualFundBloc>(),
        ),
      ],
      child: BlocProvider(
        create: (context) =>
            context.read<AuthBloc>()..add(AuthCheckRequested()),
        child:
             MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Al-Sulthan',
              theme: AppTheme.getTheme(),
              initialRoute: AppRoutes.loginPage,
              routes: AppPages.routes,
            )
       
      ),
    );
  }
}
