import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LiveGraph extends StatelessWidget {
  final FinanceChart financeChart;
  const LiveGraph({Key key, this.financeChart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilderShort(context: context, pageTitle: "LIVE GRAPH"),
      body: SingleChildScrollView(
        child: LiveGraphBody(
          financeChart: financeChart,
        ),
      ),
    );
  }
}
