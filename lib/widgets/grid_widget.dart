import 'package:animations/animations.dart';
import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/widgets/widgets.dart';

class GridWidget extends StatefulWidget {
  final List<String> symbolList;

  const GridWidget({Key key, @required this.symbolList}) : super(key: key);

  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  final List<FinanceChart> financeCharts = [];
  bool _loading = true;

  void getStockData() async {
    if (widget.symbolList != null) {
      for (int i = 0; i < widget.symbolList.length; i++) {
        FinanceChart financeChart = FinanceChart();
        await financeChart.getChartData(widget.symbolList[i]);
        await financeCharts.add(financeChart);
        print("symbol: " + widget.symbolList[i]);
      }
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
    print("fl: " + financeCharts.length.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStockData();
  }

  @override
  Widget build(BuildContext context) {
    final transitionType = ContainerTransitionType.fade;
    return _loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: GridView.builder(
              itemCount: widget.symbolList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LiveGraph(financeChart: financeCharts[index]),
                      ),
                    );
                  },
                  child: GridCardBuilder(
                    financeChart: financeCharts[index],
                  ),
                );
              },
            ),
          );
  }
}
