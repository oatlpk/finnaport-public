import 'package:finnaport/models/models.dart';
import 'package:finnaport/provider/holdings_provider.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PortfolioDataTable extends StatelessWidget {
  final String type;
  const PortfolioDataTable({Key key, this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);

    List<HoldingSummary> holdingSummary;

    performanceProvider.performance.categorySummaryList.forEach(
      (element) {
        if (element.category.toUpperCase() == type.toUpperCase()) {
          holdingSummary = element.holdingSummaryList;
        }
      },
    );

    return Container(
      child: FittedBox(
        child: DataTable(
          showCheckboxColumn: false,
          columnSpacing: 20,
          columns: <DataColumn>[
            DataColumn(
              label: dataTableTextBuilder(
                'Name',
              ),
            ),
            DataColumn(
              label: dataTableTextBuilder(
                'Quantity',
              ),
            ),
            DataColumn(
              label: dataTableTextBuilder(
                'GainLoss',
              ),
            ),
            DataColumn(
              label: dataTableTextBuilder(
                'Return AT',
              ),
            ),
            DataColumn(
              label: dataTableTextBuilder(
                'Return YTD',
              ),
            ),
          ],
          rows: holdingSummary
              .map(
                (holdings) => DataRow(
                  onSelectChanged: (bool selected) {
                    if (selected) {
                      performanceProvider
                          .setDataSource(holdings.compoundValueGraph);
                      performanceProvider
                          .setCurrentHoldingTitle(holdings.title);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Holdings(),
                            settings: RouteSettings(name: "holdings")),
                      );
                    }
                  },
                  cells: <DataCell>[
                    DataCell(
                      dataTableTextBuilder(holdings.title),
                    ),
                    DataCell(
                      dataTableTextBuilder(NumberFormat.compact(locale: "en")
                          .format(holdings.totalQuantity)),
                    ),
                    DataCell(
                      dataTableTextBuilder(NumberFormat.compact(locale: "en")
                          .format(holdings.totalGainLoss)),
                    ),
                    DataCell(
                      dataTableTextBuilder(NumberFormat.compact(locale: "en")
                          .format(holdings.percentChangeAT * 100)),
                    ),
                    DataCell(
                      dataTableTextBuilder(NumberFormat.compact(locale: "en")
                          .format(holdings.percentChangeYTD * 100)),
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget dataTableTextBuilder(String content) => Text(content,
      style: TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.center);

  void deleteHoldings(BuildContext context, HoldingsClass holdings) {
    final provider = Provider.of<HoldingsProvider>(context, listen: false);
    provider.removeHoldings(holdings);
  }
}
