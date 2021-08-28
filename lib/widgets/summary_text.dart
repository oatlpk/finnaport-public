import 'package:finnaport/provider/performance_provider.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SummaryText extends StatelessWidget {
  const SummaryText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);
    final Size screenSize = MediaQuery.of(context).size;
    performanceProvider.setCondition();
    return Container(
      height: 70,
      width: screenSize.width - 16.0,
      decoration: baseBackgroundDecoration,
      child: Column(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  buildSummaryText(
                      "Holdings",
                      (NumberFormat.compact(locale: "en")
                          .format(performanceProvider.getHoldingsOwn)),
                      double.parse(
                          performanceProvider.getHoldingsOwn.toString())),
                  buildSummaryText(
                      "Invested",
                      (NumberFormat.compact(locale: "en")
                          .format(performanceProvider.getInvestedAmount)),
                      performanceProvider.getInvestedAmount),
                  buildSummaryText(
                      "Return %",
                      (NumberFormat.compact(locale: "en")
                              .format(performanceProvider.getPercentAT)) +
                          "%",
                      performanceProvider.getPercentAT),
                  buildSummaryText(
                      "Return",
                      (NumberFormat.compact(locale: "en")
                          .format(performanceProvider.getReturn)),
                      performanceProvider.getReturn),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildSummaryText(String title, String amount, double changeColor) =>
      Row(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  title,
                  style: TextStyle(
                      color: Palette.finnaWhiteText,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  amount,
                  style: TextStyle(
                      color: changeColor <= 0
                          ? Palette.finnaRedText
                          : Palette.finnaGreenText,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      );
}
