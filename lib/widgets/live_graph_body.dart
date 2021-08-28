import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_stocks/finance_chart.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LiveGraphBody extends StatefulWidget {
  FinanceChart financeChart;
  LiveGraphBody({Key key, @required this.financeChart}) : super(key: key);

  @override
  _LiveGraphBodyState createState() => _LiveGraphBodyState();
}

class _LiveGraphBodyState extends State<LiveGraphBody> {
  QuoteData quoteData;
  bool _loading = true;

  void getQuoteDetail() async {
    quoteData = QuoteData();
    await quoteData.getQuoteData(widget.financeChart);
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getQuoteDetail();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return _loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Center(
            child: Column(
              children: [
                SizedBox(
                  height: 6,
                ),
                Container(
                  width: screenSize.width - 16.0,
                  decoration: baseBackgroundDecoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    buildLiveGraphTextHeading(
                                        widget.financeChart.symbol, 32),
                                    buildLiveGraphTextContent(
                                        widget
                                            .financeChart
                                            .stocksData[widget.financeChart
                                                    .stocksData.length -
                                                1]
                                            .adjClose,
                                        32),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: (screenSize.width - 32.0) / 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildRow(
                                                  "High",
                                                  widget
                                                      .financeChart
                                                      .stocksData[widget
                                                              .financeChart
                                                              .stocksData
                                                              .length -
                                                          1]
                                                      .high),
                                              buildRow(
                                                  "Low",
                                                  widget
                                                      .financeChart
                                                      .stocksData[widget
                                                              .financeChart
                                                              .stocksData
                                                              .length -
                                                          1]
                                                      .low),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: (screenSize.width - 32.0) / 2,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              buildRow(
                                                  "Close",
                                                  widget
                                                      .financeChart
                                                      .stocksData[widget
                                                              .financeChart
                                                              .stocksData
                                                              .length -
                                                          1]
                                                      .close),
                                              buildRow(
                                                  "Open",
                                                  widget
                                                      .financeChart
                                                      .stocksData[widget
                                                              .financeChart
                                                              .stocksData
                                                              .length -
                                                          1]
                                                      .open),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SyncfusionLineChartMarket(
                  financeChart: widget.financeChart,
                ),
                SyncfusionSparklineBarChart(financeChart: widget.financeChart),
                Container(
                  width: screenSize.width - 16.0,
                  decoration: baseBackgroundDecoration,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Stack(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: (screenSize.width - 32.0) / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildRow("Bid",
                                              quoteData.quoteData['bid']),
                                          buildRow("Bid Size",
                                              quoteData.quoteData['bidSize']),
                                          buildRow(
                                              "Volume",
                                              quoteData.quoteData[
                                                  'regularMarketVolume']),
                                          buildRow(
                                              "Pre-mkt Price",
                                              quoteData
                                                  .quoteData['preMarketPrice']),
                                          buildRow(
                                              "50-days Avg",
                                              quoteData.quoteData[
                                                  'fiftyDayAverage']),
                                          buildRow(
                                              "200-days Avg",
                                              quoteData.quoteData[
                                                  'twoHundredDayAverage']),
                                          buildRow(
                                              "52-wk High",
                                              quoteData.quoteData[
                                                  'fiftyTwoWeekHighChange']),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: (screenSize.width - 32.0) / 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          buildRow("Ask",
                                              quoteData.quoteData['ask']),
                                          buildRow("Ask Size",
                                              quoteData.quoteData['askSize']),
                                          buildRow(
                                              "Change %",
                                              quoteData.quoteData[
                                                  'regularMarketChangePercent']),
                                          buildRow(
                                              "Post-mkt Price",
                                              quoteData.quoteData[
                                                  'postMarketPrice']),
                                          buildRow(
                                              "50-days %",
                                              quoteData.quoteData[
                                                  'fiftyDayAverageChangePercent']),
                                          buildRow(
                                              "200-days %",
                                              quoteData.quoteData[
                                                  'twoHundredDayAverageChangePercent']),
                                          buildRow(
                                              "52-wk Low",
                                              quoteData.quoteData[
                                                  'fiftyTwoWeekLowChange']),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: (screenSize.width - 32.0) / 2,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Palette.finnaGreen),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Sell',
                          style: TextStyle(
                              color: Palette.finnaGreen,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    SizedBox(
                      height: 50,
                      width: (screenSize.width - 32.0) / 2,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.finnaGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'Buy',
                          style: TextStyle(
                              color: Palette.finnaDarkBox,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  Widget buildRow(String textHeader, dynamic textContent) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildLiveGraphTextHeading(textHeader, 18),
          buildLiveGraphTextContent(textContent, 18),
        ],
      );

  Widget buildLiveGraphTextHeading(String text, double fontSize) => Container(
        child: Text(
          text,
          style: TextStyle(
            color: text == widget.financeChart.symbol
                ? Colors.white.withOpacity(0.85)
                : Colors.white.withOpacity(0.6),
            fontSize: fontSize,
          ),
          textAlign: TextAlign.left,
        ),
      );

  Widget buildLiveGraphTextContent(dynamic text, double fontSize) => Container(
        child: Text(
          text.toStringAsFixed(3),
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: fontSize,
          ),
        ),
      );
}
