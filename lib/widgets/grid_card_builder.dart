import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';

class GridCardBuilder extends StatelessWidget {
  final FinanceChart financeChart; //Maybe have to remove final**

  const GridCardBuilder({Key key, @required this.financeChart})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.finnaDarkBox,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 10),
                  buildGridText(financeChart.symbol, 18),
                  buildGridText(
                      "Vol: " +
                          financeChart
                              .stocksData[financeChart.stocksData.length - 1]
                              .volume
                              .toString(),
                      12),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SyncfusionSparklineLineChart(
                      height: 80,
                      width: 120,
                      financeChart: financeChart,
                    ),
                  ),
                  buildGridText(
                      financeChart
                          .stocksData[financeChart.stocksData.length - 1]
                          .adjClose
                          .toStringAsFixed(3),
                      18),
                  buildGridText(
                      ((((financeChart
                                              .stocksData[financeChart
                                                      .stocksData.length -
                                                  1]
                                              .adjClose) /
                                          (financeChart
                                              .stocksData[financeChart
                                                      .stocksData.length -
                                                  2]
                                              .adjClose)) -
                                      1) *
                                  100)
                              .toStringAsFixed(3) +
                          "%",
                      12),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

Widget buildGridText(String text, double fontSize) => Container(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white.withOpacity(0.85),
          fontSize: fontSize,
        ),
      ),
    );
