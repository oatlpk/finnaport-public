//FOR API
import 'dart:convert';
import 'package:finnaport/models/for_stocks/stocks_data.dart';
import 'package:http/http.dart' as http;

class Stocks {
  List<StocksData> chartData = [];

  Future<void> getChartData(String symbol) async {
    String url =
       //api here
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      jsonData["ChartData"].forEach(
        (element) {
          if (element['AdjClose'] != null) {
            StocksData stock = StocksData(
              open: double.parse(element['Open']),
              low: double.parse(element['Low']),
              high: double.parse(element['High']),
              close: double.parse(element['Close']),
              adjClose: double.parse(element['AdjClose']),
              volume: element['Volume'],
              timeStamp: element['Timestamp'],
            );
            chartData.add(stock);
          }
        },
      );
    }
  }
}
