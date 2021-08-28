import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/provider/holdings_provider.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HoldingDataTable extends StatelessWidget {
  const HoldingDataTable({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HoldingsProvider>(context);
    final holdingsList = provider.holdingsList;
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);
    final Size screenSize = MediaQuery.of(context).size;

    List<HoldingsClass> individualHoldingList = [];

    holdingsList.forEach((element) {
      if (element.title == performanceProvider.getCurrentHoldingTitle) {
        individualHoldingList.add(element);
      }
    });

    individualHoldingList.forEach((element) {
      print(element);
    });

    return individualHoldingList.isEmpty
        ? Center(child: Container(child: Text('You have no holdings')))
        : Container(
            width: screenSize.width - 16.0,
            decoration: baseBackgroundDecoration,
            child: FittedBox(
              child: DataTable(
                sortAscending: false,
                sortColumnIndex: 0,
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
                      'B/S',
                    ),
                  ),
                  DataColumn(
                    label: dataTableTextBuilder(
                      'Price',
                    ),
                  ),
                  DataColumn(
                    label: dataTableTextBuilder(
                      'Quantity',
                    ),
                  ),
                  DataColumn(
                    label: dataTableTextBuilder(
                      'Date',
                    ),
                  ),
                  DataColumn(
                    label: dataTableTextBuilder(
                      'Brokerage',
                    ),
                  ),
                ],
                rows: individualHoldingList
                    .map(
                      (holdings) => DataRow(
                        onSelectChanged: (bool selected) {
                          if (selected) {
                            newTaskModalBottomSheet(context, holdings);
                          }
                        },
                        cells: <DataCell>[
                          DataCell(
                            dataTableTextBuilder(holdings.title),
                          ),
                          DataCell(
                            dataTableTextBuilder(holdings.action),
                          ),
                          DataCell(
                            dataTableTextBuilder(
                                NumberFormat.compact(locale: "en")
                                    .format(double.parse(holdings.price))),
                          ),
                          DataCell(
                            dataTableTextBuilder(
                                NumberFormat.compact(locale: "en")
                                    .format(double.parse(holdings.quantity))),
                          ),
                          DataCell(
                            dataTableTextBuilder(holdings.date),
                          ),
                          DataCell(
                            dataTableTextBuilder(holdings.brokerage),
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
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: false);
    performanceProvider.getChartDataFromServer();
  }

  void editHoldings(BuildContext context, HoldingsClass holdings) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditHolding(holdings: holdings),
        ),
      );

  void newTaskModalBottomSheet(context, holdings) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Color(0xFF020811),
          child: Container(
            decoration: BoxDecoration(
              color: Palette.finnaDarkBox,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(14.0),
                topLeft: Radius.circular(14.0),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.edit,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  title: Text(
                    'Edit',
                    style: TextStyle(color: Colors.white.withOpacity(0.85)),
                  ),
                  onTap: () => editHoldings(context, holdings),
                ),
                ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.white.withOpacity(0.85),
                  ),
                  title: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white.withOpacity(0.85)),
                  ),
                  onTap: () {
                    deleteHoldings(context, holdings);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
