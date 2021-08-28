import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class SyncfusionLineChartMarket extends StatelessWidget {
  final FinanceChart financeChart;
  const SyncfusionLineChartMarket({Key key, this.financeChart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: screenSize.width - 16.0,
        height: 325,
        decoration: baseBackgroundDecoration,
        child: SfCartesianChart(
          plotAreaBorderWidth: 0,
          borderWidth: 1,
          margin: EdgeInsets.fromLTRB(2, 15, 8, 10),
          tooltipBehavior: performanceProvider.getToolTipBehavior,
          zoomPanBehavior: performanceProvider.getZoomPanBehavior,
          series: <ChartSeries<StocksData, DateTime>>[
            AreaSeries<StocksData, DateTime>(
              borderWidth: 2,
              borderColor: financeChart.stocksData[0].adjClose >
                      financeChart
                          .stocksData[financeChart.stocksData.length - 1]
                          .adjClose
                  ? Palette.finnaRedText
                  : Palette.finnaGreen,
              gradient: financeChart.stocksData[0].adjClose >
                      financeChart
                          .stocksData[financeChart.stocksData.length - 1]
                          .adjClose
                  ? performanceProvider.getRedGradientColors
                  : performanceProvider.getGreenGradientColors,
              dataSource: financeChart.stocksData,
              xValueMapper: (StocksData stocks, _) => stocks.timeStamp,
              yValueMapper: (StocksData stocks, _) => stocks.adjClose,
              enableTooltip: true,
            ),
          ],
          primaryYAxis: NumericAxis(
            numberFormat: NumberFormat.compact(locale: 'en'),
            isVisible: true,
            majorGridLines: MajorGridLines(
              dashArray: [5, 5],
            ),
            axisLine: AxisLine(
              width: 0,
            ),
          ),
          primaryXAxis: DateTimeAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorGridLines: MajorGridLines(width: 0),
            dateFormat: DateFormat.MMMd(),
            intervalType: DateTimeIntervalType.days,
          ),
        ),
      ),
    );
  }
}
