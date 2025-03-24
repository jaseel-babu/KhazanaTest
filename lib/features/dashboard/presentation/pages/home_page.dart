import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khazana_fintech_task/core/constant/config/routes/app_routes.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';
import 'package:khazana_fintech_task/core/utils/show_snackbar.dart';
import 'package:khazana_fintech_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/bloc/mutualfund%20bloc/mutual_fund_bloc.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/pages/fund_detailes_page.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/widgets/line_chart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MutualFundBloc>().add(LoadMutualFunds());
    super.initState();
  }

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Column(
                children: [
                  LegendItem(
                      color: Colors.blue,
                      text: "Your Investments",
                      value: "-19.75%"),
                  SizedBox(width: 20),
                  LegendItem(
                      color: Colors.orange,
                      text: "Nifty Midcap 150",
                      value: "-12.97%"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              const LineChartWidget(),
              BlocBuilder<MutualFundBloc, MutualFundState>(
                builder: (context, state) {
                  if (state is MutualFundLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MutualFundLoaded) {
                    return SizedBox(
                      height: 500,
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const Text("All Funds",
                              style: TextStyle(
                                  color: AppColor.whiteColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold)),
                          ...state.allFunds.map(
                            (fund) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FundDetailesPage(fund: fund),
                                    ),
                                  );
                                },
                                tileColor: AppColor.primaryBlueColor,
                                title: Text(
                                  fund.fundName,
                                  style: const TextStyle(
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                subtitle: Text(
                                  fund.investment.investedAmount > 0
                                      ? "Invested: ₹${fund.investment.investedAmount}"
                                      : "Not Invested",
                                  style: const TextStyle(
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is MutualFundError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text("No data available"));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  final String value;

  const LegendItem(
      {required this.color,
      required this.text,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 2,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 14),
        ),
        const SizedBox(width: 5),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
