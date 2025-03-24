import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:khazana_fintech_task/core/constant/theme/app_color.dart';

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: LineChart(LineChartData(
        backgroundColor: AppColor.backgroundColor,
        lineTouchData: LineTouchData(
          enabled: true,
          touchTooltipData: LineTouchTooltipData(
            tooltipRoundedRadius: 8.0, // Rounded corners
            fitInsideHorizontally: true, maxContentWidth: 240,
            fitInsideVertically: true,
            getTooltipColor: (LineBarSpot touchedSpot) {
              return const Color.fromARGB(255, 71, 71, 71).withOpacity(0.9);
            },
            tooltipPadding: const EdgeInsets.all(8),
            tooltipBorder: const BorderSide(color: AppColor.primaryBlueColor),
            getTooltipItems: (List<LineBarSpot> touchedSpots) {
              return touchedSpots.map((spot) {
                String label;
                if (spot.barIndex == 0) {
                  label = 'Your Investment: ₹${spot.y.toStringAsFixed(2)}';
                } else {
                  label = 'Nifty Midcap: ₹${spot.y.toStringAsFixed(2)}';
                }
                return LineTooltipItem(
                  label,
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text:
                          '\n${spot.x.toInt()}-01-2025', // Customize date format
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                );
              }).toList();
            },
          ),
          getTouchedSpotIndicator: (barData, indicators) {
            return indicators.map((index) {
              return const TouchedSpotIndicatorData(
                FlLine(
                    color: Colors.blueAccent, strokeWidth: 1), // Vertical Line
                FlDotData(show: false),
              );
            }).toList();
          },
          touchCallback:
              (FlTouchEvent event, LineTouchResponse? touchResponse) {
            // You can handle touch events here if needed
          },
        ),
        gridData: const FlGridData(show: false),
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(
          show: true,
          border: const Border(
            bottom: BorderSide(color: AppColor.borderColor),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            dotData: const FlDotData(show: false),
            spots: const [
              FlSpot(0, 10),
              FlSpot(1, 8),
              FlSpot(2, 12),
              FlSpot(3, 7),
              FlSpot(4, 10),
              FlSpot(5, 10),
              FlSpot(6, 10),
              FlSpot(7, 8),
              FlSpot(8, 6),
              FlSpot(9, 8),
              FlSpot(10, 12),
            ],
            isCurved: true,
            color: Colors.blue,
            belowBarData:
                BarAreaData(show: true, color: Colors.grey.withOpacity(0.1)),
          ),
          LineChartBarData(
            dotData: const FlDotData(show: false),
            spots: const [
              FlSpot(0, 8),
              FlSpot(1, 6),
              FlSpot(2, 10),
              FlSpot(3, 5),
              FlSpot(4, 12),
              FlSpot(5, 8),
              FlSpot(6, 6),
              FlSpot(7, 7),
              FlSpot(8, 10),
              FlSpot(9, 8),
              FlSpot(10, 12),
            ],
            isCurved: true,
            color: Colors.orange,
          ),
        ],
      )),
    );
  }
}
