import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SyncfusionLineChartPortfolio extends StatelessWidget {
  const SyncfusionLineChartPortfolio({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("syncfusion");
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);

    String pageName;
    pageName = ModalRoute.of(context).settings.name;

    final Size screenSize = MediaQuery.of(context).size;
    pageName == null ? performanceProvider.setCondition() : null;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        width: screenSize.width - 16.0,
        height: pageName == null ? 350 : 310,
        decoration: baseBackgroundDecoration,
        child: Column(
          children: [
            SfCartesianChart(
              plotAreaBorderWidth: 0,
              borderWidth: 1,
              margin: EdgeInsets.fromLTRB(2, 25, 8, 0),
              tooltipBehavior: performanceProvider.getToolTipBehavior,
              zoomPanBehavior: performanceProvider.getZoomPanBehavior,
              series: <ChartSeries>[
                AreaSeries<CompoundValue, dynamic>(
                  borderWidth: 2,
                  borderColor: performanceProvider.getDataSource[0].todayValue >
                          performanceProvider
                              .getDataSource[
                                  performanceProvider.getDataSource.length - 1]
                              .todayValue
                      ? Palette.finnaRedText
                      : Palette.finnaGreen,
                  gradient: performanceProvider.getDataSource[0].todayValue >
                          performanceProvider
                              .getDataSource[
                                  performanceProvider.getDataSource.length - 1]
                              .todayValue
                      ? performanceProvider.getRedGradientColors
                      : performanceProvider.getGreenGradientColors,
                  dataSource: performanceProvider.getDataSource,
                  xValueMapper: (CompoundValue compoundValueX, _) =>
                      compoundValueX.timeStamp,
                  yValueMapper: (CompoundValue compoundValueY, _) =>
                      compoundValueY.todayValue,
                  enableTooltip: true,
                  markerSettings: MarkerSettings(
                      isVisible: false,
                      color: performanceProvider.getDataSource[0].todayValue >
                              performanceProvider
                                  .getDataSource[
                                      performanceProvider.getDataSource.length -
                                          1]
                                  .todayValue
                          ? Palette.finnaRedText
                          : Palette.finnaGreen,
                      borderColor: performanceProvider
                                  .getDataSource[0].todayValue >
                              performanceProvider
                                  .getDataSource[
                                      performanceProvider.getDataSource.length -
                                          1]
                                  .todayValue
                          ? Palette.finnaRedText
                          : Palette.finnaGreen),
                ),
              ],
              primaryXAxis: DateTimeAxis(
                dateFormat: DateFormat.MMMd(),
                intervalType: DateTimeIntervalType.days,
                edgeLabelPlacement: EdgeLabelPlacement.shift,
                majorGridLines: MajorGridLines(width: 0),
              ),
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
            ),
            pageName == null ? ChoiceChipForm() : Container(),
          ],
        ),
      ),
    );
  }
}
