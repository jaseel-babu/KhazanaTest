import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarChartWidget extends StatelessWidget {
  const BarChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Saving A/C', 3, 8),
      ChartData('Category Avg.', 5, 10),
      ChartData('Direct Plan', 8, 13),
    ];

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
        labelStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
      primaryYAxis: const NumericAxis(
        isVisible: false,
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: <CartesianSeries>[
        // Grey Base Segment
        StackedColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.greyValue,
          color: Colors.grey[700],
          width: 0.4,
          spacing: 0.2,
        ),
        // Green Top Segment
        StackedColumnSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.category,
          yValueMapper: (ChartData data, _) => data.greenValue,
          color: Colors.green,
          width: 0.4,
          spacing: 0.2,
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelAlignment: ChartDataLabelAlignment.top,
            textStyle: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class ChartData {
  final String category;
  final double greenValue;
  final double greyValue;
  ChartData(this.category, this.greenValue, this.greyValue);
}
