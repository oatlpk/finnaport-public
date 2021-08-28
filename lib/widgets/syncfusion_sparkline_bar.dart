import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class SyncfusionSparklineBarChart extends StatelessWidget {
  FinanceChart financeChart;
  SyncfusionSparklineBarChart({Key key, this.financeChart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        height: 70,
        width: screenSize.width - 16.0,
        decoration: BoxDecoration(
          color: Palette.finnaDarkBox,
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: Colors.grey,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Palette.finnaDropShadow.withOpacity(0.50),
              blurRadius: 4,
              offset: Offset(0, 4), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SfSparkBarChart.custom(
            xValueMapper: (int index) =>
                financeChart.stocksData[index].timeStamp,
            yValueMapper: (int index) => financeChart.stocksData[index].volume,
            dataCount: financeChart.stocksData.length,
            color: Colors.grey.withOpacity(0.7),
            highPointColor: Colors.grey.withOpacity(0.7),
            lowPointColor: Colors.grey.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
