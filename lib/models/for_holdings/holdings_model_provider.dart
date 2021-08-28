class HoldingField {
  static const createdTime = 'createdTime';
}

class HoldingsClass {
  DateTime createdTime;
  String title;
  String price;
  String quantity;
  String date;
  String brokerage;
  String investmentType;
  String accountNumber;
  String action;
  String totalPrice;
  String commission;
  String vat;
  String totalAmount;
  String id;
  bool isDone;

  HoldingsClass({
    this.createdTime,
    this.title = '',
    this.price = '',
    this.quantity = '',
    this.date = '',
    this.brokerage = '',
    this.investmentType = '',
    this.accountNumber = '',
    this.action = '',
    this.totalPrice = '',
    this.commission,
    this.vat,
    this.totalAmount = '',
    this.id = '',
    this.isDone = false,
  });
}
