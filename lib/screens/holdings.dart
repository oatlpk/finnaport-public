import 'package:finnaport/config/config.dart';
import 'package:finnaport/widgets/holding_data_table.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';

class Holdings extends StatelessWidget {
  const Holdings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarBuilderShort(context: context, pageTitle: "HOLDINGS"),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SyncfusionLineChartPortfolio(),
              Padding(
                padding: const EdgeInsets.only(top: 6.0, bottom: 5.0),
                child: Container(
                  width: screenSize.width - 16.0,
                  child: buildPortfolioHeadings("Summary"),
                ),
              ),
              SummaryText(),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: screenSize.width - 16.0,
                  child: buildPortfolioHeadings("Your Holdings"),
                ),
              ),
              SizedBox(height: 5),
              HoldingDataTable(),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPortfolioHeadings(String heading) => Text(
        heading,
        style: TextStyle(
          color: Palette.finnaGreenText,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      );
}
