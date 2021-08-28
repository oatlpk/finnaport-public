import 'package:finnaport/provider/performance_provider.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpandingTile extends StatelessWidget {
  const ExpandingTile({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: false);
    performanceProvider.setExpansionTile();

    return Container(
      child: Column(
        children: <Widget>[
          buildExpansionTile(
              "Stocks",
              performanceProvider.getStockTileReturn,
              performanceProvider.getStockTilePercentAT,
              performanceProvider.getStockTileInvestedAmount),
          buildExpansionTile(
              "Crypto",
              performanceProvider.getCryptoTileReturn,
              performanceProvider.getCryptoTilePercentAT,
              performanceProvider.getCryptoTileInvestedAmount),
          buildExpansionTile(
              "Funds",
              performanceProvider.getFundsTileReturn,
              performanceProvider.getFundsTilePercentAT,
              performanceProvider.getFundsTileInvestedAmount),
        ],
      ),
    );
  }

  Widget buildExpansionTile(String type, double tileReturn,
          double tileReturnPercent, double tileReturnProportion) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Card(
          color: Palette.finnaDarkBox,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(14.0),
            ),
          ),
          elevation: 3.0,
          child: ExpansionTile(
            collapsedIconColor: Palette.finnaGreen,
            iconColor: Palette.finnaGreen,
            title: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      width: 80,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            type,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'portion: ' +
                                (NumberFormat.compact(locale: "en")
                                    .format(tileReturnProportion)) +
                                "%",
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 63,
                      width: 135,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 4),
                      width: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            (NumberFormat.compact(locale: "en")
                                .format(tileReturn)),
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.85),
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            (NumberFormat.compact(locale: "en")
                                    .format(tileReturnPercent)) +
                                "%",
                            style: TextStyle(
                              color: tileReturnPercent <= 0
                                  ? Palette.finnaRedText
                                  : Palette.finnaGreenText,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            children: <Widget>[
              PortfolioDataTable(
                type: type,
              )
            ],
          ),
        ),
      );
}
