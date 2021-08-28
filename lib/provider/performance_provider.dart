import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncfusion_flutter_charts/charts.dart';

class PerformanceProvider extends ChangeNotifier {
  Performance performance;

  Future<void> getChartDataFromServer() async {
    String uid = FirebaseAuth.instance.currentUser.uid;
    String url = //api here
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (response.statusCode == 200) {
      Performance performanceGetData = Performance(
        allHoldingsOwned: jsonData['allHoldingsOwned'],
        allGainLoss: double.parse(jsonData['allGainLoss']),
        allInvestedAmount: double.parse(jsonData['allInvestedAmount']),
        allPercentChangeAT: double.parse(jsonData['allPercentChange']),
        performanceGraph:
            jsonData['performanceGraph'].map<CompoundValue>((compoundValue) {
          CompoundValue compoundValueGetData = CompoundValue(
              timeStamp: DateTime.fromMillisecondsSinceEpoch(
                  compoundValue["timestamp"] * 1000),
              todayValue: double.parse(compoundValue["todayValue"]));
          return compoundValueGetData;
        }).toList(),
        categorySummaryList: jsonData["categorySummaryList"]
            .map<CategorySummary>((categorySummary) {
          CategorySummary categorySummaryGetData = CategorySummary(
            category: categorySummary["category"].toString(),
            holdingsOwned: categorySummary['holdingsOwned'],
            categoryGainLoss: double.parse(categorySummary["categoryGainLoss"]),
            categoryInvestedAmount:
                double.parse(categorySummary['categoryInvestedAmount']),
            categoryPercentChangeAT:
                double.parse(categorySummary['categoryPercentChangeAT']),
            compoundSummaryGraph: categorySummary["categorySummaryGraph"]
                .map<CompoundValue>((compoundValue) {
              CompoundValue compoundValueGetData = CompoundValue(
                timeStamp: DateTime.fromMillisecondsSinceEpoch(
                    compoundValue["timestamp"] * 1000),
                todayValue: double.parse(
                  compoundValue["todayValue"],
                ),
              );
              return compoundValueGetData;
            }).toList(),
            holdingSummaryList: categorySummary["holdingSummaryList"]
                .map<HoldingSummary>((holdingSummary) {
              HoldingSummary holdingSummaryGetData = HoldingSummary(
                title: holdingSummary["title"].toString(),
                investmentType: holdingSummary["investmentType"].toString(),
                totalQuantity: double.parse(holdingSummary['totalQuantity']),
                totalGainLoss: double.parse(holdingSummary["totalGainLoss"]),
                investedAmount: double.parse(holdingSummary['investedAmount']),
                percentChangeYTD:
                    double.parse(holdingSummary['percentChangeYTD']),
                percentChangeAT:
                    double.parse(holdingSummary['percentChangeAT']),
                compoundValueGraph: holdingSummary["compoundValueGraph"]
                    .map<CompoundValue>((compoundValue) {
                  CompoundValue compoundValueGetData = CompoundValue(
                    timeStamp: DateTime.fromMillisecondsSinceEpoch(
                        compoundValue["timestamp"] * 1000),
                    todayValue: double.parse(
                      compoundValue["todayValue"],
                    ),
                  );
                  return compoundValueGetData;
                }).toList(),
              );
              return holdingSummaryGetData;
            }).toList(),
          );
          return categorySummaryGetData;
        }).toList(),
      );
      performance = performanceGetData;
    }
    print("1: " + performance.allGainLoss.toString());
    print("2: " + performance.performanceGraph[0].timeStamp.toString());
    print("3: " + performance.categorySummaryList.toString());
    notifyListeners();
  }

  //////////////////////////
  String _typeChoice = "ALL";

  void setTypeChoice(String text) {
    _typeChoice = text;
    notifyListeners();
  }

  String get getTypeChoice => _typeChoice;

  double _getReturn;
  double _getPercentAT;
  int _getHoldingsOwn;
  double _getInvestedAmount; //Proportion
  CategorySummary category;
  int _index;
  List<CompoundValue> _getDataSource;
  String _getHoldingTitle;

  void setDataSource(List<CompoundValue> dataSource) {
    _getDataSource = dataSource;
  }

  void setCurrentHoldingTitle(String holdingTitle) {
    _getHoldingTitle = holdingTitle;
  }

  void setCondition() {
    if (getTypeChoice == "ALL") {
      _getReturn = performance.allGainLoss;
      _getDataSource = performance.performanceGraph;
      _getPercentAT = performance.allPercentChangeAT;
      _getHoldingsOwn = performance.allHoldingsOwned;
      _getInvestedAmount = performance.allInvestedAmount;
    } else if (getTypeChoice == "STOCKS") {
      _index = performance.categorySummaryList
          .indexWhere((element) => element.category == "STOCKS");
      category = performance.categorySummaryList[_index];
      _getReturn = category.categoryGainLoss;
      _getDataSource = category.compoundSummaryGraph;
      _getPercentAT = category.categoryPercentChangeAT;
      _getHoldingsOwn = category.holdingsOwned;
      _getInvestedAmount = category.categoryInvestedAmount;
    } else if (getTypeChoice == "CRYPTO") {
      _index = performance.categorySummaryList.indexWhere(
        (element) => element.category == "CRYPTO",
      );
      category = performance.categorySummaryList[_index];
      _getReturn = category.categoryGainLoss;
      _getDataSource = category.compoundSummaryGraph;
      _getPercentAT = category.categoryPercentChangeAT;
      _getHoldingsOwn = category.holdingsOwned;
      _getInvestedAmount = category.categoryInvestedAmount;
    } else {
      _index = performance.categorySummaryList.indexWhere(
        (element) => element.category == "FUNDS",
      );
      category = performance.categorySummaryList[_index];
      _getReturn = category.categoryGainLoss;
      _getDataSource = category.compoundSummaryGraph;
      _getPercentAT = category.categoryPercentChangeAT;
      _getHoldingsOwn = category.holdingsOwned;
      _getInvestedAmount = category.categoryInvestedAmount;
    }
  }

  double get getReturn => _getReturn;
  double get getPercentAT => _getPercentAT;
  int get getHoldingsOwn => _getHoldingsOwn;
  double get getInvestedAmount => _getInvestedAmount;
  List<CompoundValue> get getDataSource => _getDataSource;
  String get getCurrentHoldingTitle => _getHoldingTitle;
  Performance get getPerformance => performance;

  //////////////////////////

  double _getStockTileReturn;
  double _getStockTilePercentAT;
  double _getStockTileInvestedAmount;
  double _getCryptoTileReturn;
  double _getCryptoTilePercentAT;
  double _getCryptoTileInvestedAmount;
  double _getFundsTileReturn;
  double _getFundsTilePercentAT;
  double _getFundsTileInvestedAmount;
  CategorySummary categoryTile;
  int _indexTile;

  void setExpansionTile() {
    setStockExpansionTile();
    setCryptoExpansionTile();
    setFundsExpansionTile();
  }

  void setStockExpansionTile() {
    _indexTile = performance.categorySummaryList.indexWhere(
      (element) => element.category == "STOCKS",
    );
    categoryTile = performance.categorySummaryList[_indexTile];
    _getStockTileReturn = categoryTile.categoryGainLoss;
    _getStockTilePercentAT = categoryTile.categoryPercentChangeAT;
    _getStockTileInvestedAmount =
        (categoryTile.categoryInvestedAmount / performance.allInvestedAmount) *
            100;
  }

  void setCryptoExpansionTile() {
    _indexTile = performance.categorySummaryList.indexWhere(
      (element) => element.category == "CRYPTO",
    );
    categoryTile = performance.categorySummaryList[_indexTile];
    _getCryptoTileReturn = categoryTile.categoryGainLoss;
    _getCryptoTilePercentAT = categoryTile.categoryPercentChangeAT;
    _getCryptoTileInvestedAmount =
        (categoryTile.categoryInvestedAmount / performance.allInvestedAmount) *
            100;
  }

  void setFundsExpansionTile() {
    _indexTile = performance.categorySummaryList.indexWhere(
      (element) => element.category == "FUNDS",
    );
    categoryTile = performance.categorySummaryList[_indexTile];
    _getFundsTileReturn = categoryTile.categoryGainLoss;
    _getFundsTilePercentAT = categoryTile.categoryPercentChangeAT;
    _getFundsTileInvestedAmount =
        (categoryTile.categoryInvestedAmount / performance.allInvestedAmount) *
            100;
  }

  double get getStockTileReturn => _getStockTileReturn;
  double get getStockTilePercentAT => _getStockTilePercentAT;
  double get getStockTileInvestedAmount => _getStockTileInvestedAmount;
  double get getCryptoTileReturn => _getCryptoTileReturn;
  double get getCryptoTilePercentAT => _getCryptoTilePercentAT;
  double get getCryptoTileInvestedAmount => _getCryptoTileInvestedAmount;
  double get getFundsTileReturn => _getFundsTileReturn;
  double get getFundsTilePercentAT => _getFundsTilePercentAT;
  double get getFundsTileInvestedAmount => _getFundsTileInvestedAmount;

  //////////////////////////
  TooltipBehavior _tooltipBehavior =
      TooltipBehavior(enable: true); //For syncfusion
  ZoomPanBehavior _zoomPanBehavior = ZoomPanBehavior(
    enablePinching: true,
    zoomMode: ZoomMode.xy,
    enablePanning: true,
  );
  LinearGradient _gradientGreenColors = getGreenGradient();
  LinearGradient _gradientRedColors = getRedGradient();

  TooltipBehavior get getToolTipBehavior => _tooltipBehavior;
  ZoomPanBehavior get getZoomPanBehavior => _zoomPanBehavior;
  LinearGradient get getGreenGradientColors => _gradientGreenColors;
  LinearGradient get getRedGradientColors => _gradientRedColors;
}
