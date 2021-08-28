import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SyncfusionSparklineLineChart extends StatelessWidget {
  final double height;
  final double width;
  final FinanceChart financeChart;

  const SyncfusionSparklineLineChart(
      {Key key, this.height, this.width, this.financeChart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SfSparkAreaChart.custom(
          borderWidth: 1.5,
          borderColor: financeChart.stocksData[0].adjClose >
                  financeChart
                      .stocksData[financeChart.stocksData.length - 1].adjClose
              ? Palette.finnaRedText
              : Palette.finnaGreen,
          xValueMapper: (int index) => financeChart.stocksData[index].timeStamp,
          yValueMapper: (int index) => financeChart.stocksData[index].adjClose,
          dataCount: financeChart.stocksData.length,
          color: financeChart.stocksData[0].adjClose >
                  financeChart
                      .stocksData[financeChart.stocksData.length - 1].adjClose
              ? Palette.finnaRedText.withOpacity(0.3)
              : Palette.finnaGreen.withOpacity(0.3),
          axisLineWidth: 0,
        ),
      ),
    );
  }
}
