class Performance {
  int allHoldingsOwned;
  double allGainLoss;
  double allInvestedAmount;
  double allPercentChangeAT;
  List<CompoundValue> performanceGraph;
  List<CategorySummary> categorySummaryList;

  Performance({
    this.allHoldingsOwned,
    this.allGainLoss,
    this.allInvestedAmount,
    this.allPercentChangeAT,
    this.performanceGraph,
    this.categorySummaryList,
  });
}

class CategorySummary {
  String category;
  int holdingsOwned;
  double categoryGainLoss;
  double categoryInvestedAmount;
  double categoryPercentChangeAT;
  List<CompoundValue> compoundSummaryGraph;
  List<HoldingSummary> holdingSummaryList;

  CategorySummary({
    this.category,
    this.holdingsOwned,
    this.categoryGainLoss,
    this.categoryInvestedAmount,
    this.categoryPercentChangeAT,
    this.compoundSummaryGraph,
    this.holdingSummaryList,
  });
}

class HoldingSummary {
  String title;
  String investmentType;
  double totalQuantity;
  double totalGainLoss;
  double investedAmount;
  double percentChangeYTD;
  double percentChangeAT;
  List<CompoundValue> compoundValueGraph;

  HoldingSummary({
    this.title,
    this.investmentType,
    this.totalQuantity,
    this.totalGainLoss,
    this.investedAmount,
    this.percentChangeYTD,
    this.percentChangeAT,
    this.compoundValueGraph,
  });
}

class CompoundValue {
  //int timeStamp;
  DateTime timeStamp;
  double todayValue;

  CompoundValue({
    this.timeStamp,
    this.todayValue,
  });
}
