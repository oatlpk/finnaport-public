import 'dart:convert';
import 'package:finnaport/models/models.dart';
import 'package:http/http.dart' as http;

class QuoteData {
  dynamic quoteData;

  QuoteData({this.quoteData});

  Future<void> getQuoteData(FinanceChart financeChart) async {
    var queryParameters = {
      'symbol': financeChart.symbol,
      'quotetype': financeChart.quoteType,
      'timestamp': (financeChart.stocksData[financeChart.stocksData.length - 1]
                  .timeStamp.millisecondsSinceEpoch /
              1000)
          .toString(),
    };

    var uri = Uri.http(
       //api here
    print(uri);
    var response = await http.get(uri);
    var jsonData = jsonDecode(response.body);
    quoteData = jsonData;
    print("QuoteData Getter");
  }
}
