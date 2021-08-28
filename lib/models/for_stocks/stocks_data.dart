//FOR API
import 'dart:convert';

StocksData stocksDataFromJson(String str) => StocksData();

String stocksDataToJson(StocksData data) => json.encode(data.toJson());

class StocksData {
  double open;
  double low;
  double high;
  double close;
  double adjClose;
  int volume;
  DateTime timeStamp;
  StocksData(
      {this.open,
      this.low,
      this.high,
      this.close,
      this.adjClose,
      this.volume,
      this.timeStamp});

  factory StocksData.fromJson(Map<String, dynamic> json) => StocksData(
        open: json["Open"],
        low: json["Low"],
        high: json["High"],
        close: json["Close"],
        adjClose: json["AdjClose"],
        volume: json["Volume"],
        timeStamp: json["Timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "Open": open,
        "Low": low,
        "High": high,
        "Close": close,
        "AdjClose": adjClose,
        "Volume": volume,
        "Timestamp": timeStamp,
      };
}
