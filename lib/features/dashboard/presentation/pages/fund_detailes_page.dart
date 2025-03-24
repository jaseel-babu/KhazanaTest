import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';
import 'package:khazana_fintech_task/features/dashboard/domain/entities/mutual_fund_entity.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/pages/home_page.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/widgets/barchart.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/widgets/custom_slider.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/widgets/investment_widget.dart';
import 'package:khazana_fintech_task/features/dashboard/presentation/widgets/line_chart.dart';

class FundDetailesPage extends StatefulWidget {
  const FundDetailesPage({super.key, required this.fund});
  final MutualFundEntity fund;
  @override
  State<FundDetailesPage> createState() => _FundDetailesPageState();
}

class _FundDetailesPageState extends State<FundDetailesPage> {
  int _selectedIndex = 5;

  final List<String> yearFilter = ["1M", "3M", "6M", "1Y", "3Y", "MAX"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_add_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.fund.fundName,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Nav ₹ 10.42  ↑ ₹ +4.7  ↓ -3.7",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 16),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.black, // Background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border: Border.all(color: Colors.grey[800]!), // Subtle border
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildColumn("Invested",
                        widget.fund.investment.investedAmount.toString()),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey[700],
                    ),
                    _buildColumn("Current Value",
                        widget.fund.investment.currentValue.toString(),
                        isBold: true),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey[700],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Total Gain",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 12),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Text(
                              "₹${widget.fund.investment.totalGain.toString()}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                                widget.fund.investment.totalGain < 0
                                    ? Icons.keyboard_arrow_down
                                    : Icons.keyboard_arrow_up,
                                color: widget.fund.investment.totalGain < 0
                                    ? Colors.red
                                    : Colors.green,
                                size: 16),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.fund.investment.percentageLoss}",
                              style: TextStyle(
                                  color: widget.fund.investment.totalGain < 0
                                      ? Colors.red
                                      : Colors.green,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  LegendItem(
                      color: Colors.blue,
                      text: "Your Investments",
                      value: "-${widget.fund.investment.percentageLoss}%"),
                  const SizedBox(width: 20),
                  LegendItem(
                      color: Colors.orange,
                      text: "Nifty Midcap 150",
                      value: "-${widget.fund.investment.percentageLoss}%")
                ],
              ),
              const LineChartWidget(),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(yearFilter.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: _selectedIndex == index
                              ? Colors.blue
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          yearFilter[index],
                          style: TextStyle(
                            color: _selectedIndex == index
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF262626), // Background color
                  border:
                      Border.all(color: AppColor.greyColor.withOpacity(0.4)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const InvestmentWidget(),
                    const SizedBox(height: 8),
                    const CustomSlider(),
                    const SizedBox(height: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "This Fund’s past returns",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            Text(
                              "₹ 3.6 L",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Profit % (Absolute Return)",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 12),
                            ),
                            Text(
                              "${widget.fund.investment.percentageLoss}%",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 150, child: BarChartWidget()),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:
                          _actionButton("Sell ↓", AppColor.primaryBlueColor)),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: _actionButton(
                          "Invest More ↑", AppColor.primaryBlueColor)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionButton(String label, Color color) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildColumn(String label, String value, {bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.grey[500], fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
