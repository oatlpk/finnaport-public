import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finnaport/models/for_typeahead/typeahead_list.dart';
import 'package:finnaport/models/models.dart';
import 'package:finnaport/services/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HoldingsProvider extends ChangeNotifier {
  List<HoldingsClass> _holdingsList = [];

  List<HoldingsClass> get holdingsList => _holdingsList;

  void addHoldings(
    String name,
    String price,
    String quantity,
    String date,
    String brokerage,
    String investmentType,
    String accountNumber,
    String action,
    String totalPrice,
    String commission,
    String vat,
    String totalAmount,
  ) async {
    final holdings = HoldingsClass(
      createdTime: DateTime.now(),
      title: name,
      price: price,
      quantity: quantity,
      date: date,
      brokerage: brokerage,
      investmentType: investmentType,
      accountNumber: accountNumber,
      action: action,
      totalPrice: totalPrice,
      commission: commission,
      vat: vat,
      totalAmount: totalAmount,
      id: DateTime.now().toString(),
    );
    FirestoreService firestore =
        FirestoreService(FirebaseFirestore.instance, FirebaseAuth.instance);
    await firestore.addHolding(holdings);
    await fetchHoldingsFromFirestore();
  }

  void removeHoldings(HoldingsClass holdings) {
    _holdingsList.remove(holdings);
    FirestoreService firestore =
        FirestoreService(FirebaseFirestore.instance, FirebaseAuth.instance);
    firestore.removeHolding(holdings);
    notifyListeners();
  }

  void updateHoldings(
    String name,
    String price,
    String quantity,
    String date,
    String brokerage,
    String investmentType,
    String accountNumber,
    String action,
    String totalPrice,
    String commission,
    String vat,
    String totalAmount,
    String id,
  ) async {
    final holdings = HoldingsClass(
      createdTime: DateTime.now(),
      title: name,
      price: price,
      quantity: quantity,
      date: date,
      brokerage: brokerage,
      investmentType: investmentType,
      accountNumber: accountNumber,
      action: action,
      totalPrice: totalPrice,
      commission: commission,
      vat: vat,
      totalAmount: totalAmount,
      id: id,
    );
    print("ID UPDATE: " + id);
    FirestoreService firestore =
        FirestoreService(FirebaseFirestore.instance, FirebaseAuth.instance);
    await firestore.updateHolding(holdings);
    await fetchHoldingsFromFirestore();
  }

  Future<void> fetchHoldingsFromFirestore() async {
    FirestoreService firestore =
        FirestoreService(FirebaseFirestore.instance, FirebaseAuth.instance);
    _holdingsList = await firestore.getMultipleHoldings();
    _holdingsList.forEach((element) {
      print(element);
    });
    notifyListeners();
  }

  ////////////////////////////////////////////////////////
  String _displayName = "";
  String _displayPrice = "";
  String _displayQuantity = "";
  String _displayDate = "";
  String _displayBrokerage = "";
  String _displayInvestmentType = "";
  String _displayAccountNumber = "";
  String _displayAction = "";
  String _displayTotalPrice = "";
  String _displayCommission = "";
  String _displayVat = "";
  String _displayTotalAmount = "";

  void setDisplayName(String text) {
    _displayName = text;
    getInvestmentType(text);
    notifyListeners();
  }

  void setDisplayPrice(String text) {
    _displayPrice = text;
    calculation(text);
    notifyListeners();
  }

  void setDisplayPriceNoListen(String text) {
    _displayPrice = text;
  }

  void setDisplayQuantity(String text) {
    _displayQuantity = text;
    calculation(text);
    notifyListeners();
  }

  void setDisplayQuantityNoListen(String text) {
    _displayQuantity = text;
  }

  void setDisplayDate(DateTime text) {
    _displayDate = DateFormat('dd/MM/yyyy').format(text).toString();
    notifyListeners();
  }

  void setDisplayBrokerage(String text) {
    _displayBrokerage = text;
    notifyListeners();
  }

  void setDisplayInvestmentType(String text) {
    _displayInvestmentType = text;
    notifyListeners();
  }

  void setDisplayInvestmentTypeNoListen(String text) {
    _displayInvestmentType = text;
  }

  void setDisplayAccountNumber(String text) {
    _displayAccountNumber = text;
    notifyListeners();
  }

  void setDisplayAction(String text) {
    _displayAction = text;
    notifyListeners();
  }

  void setDisplayTotalPrice(String text) {
    _displayTotalPrice = text;
    notifyListeners();
  }

  void setDisplayTotalPriceNoListen(String text) {
    _displayTotalPrice = text;
  }

  void setDisplayCommission(String text) {
    _displayCommission = text;
    notifyListeners();
  }

  void setDisplayCommissionNoListen(String text) {
    _displayCommission = text;
  }

  void setDisplayVat(String text) {
    _displayVat = text;
    notifyListeners();
  }

  void setDisplayVatNoListen(String text) {
    _displayVat = text;
  }

  void setDisplayTotalAmount(String text) {
    _displayTotalAmount = text;
    notifyListeners();
  }

  void setDisplayTotalAmountNoListen(String text) {
    _displayTotalAmount = text;
  }

  void getInvestmentType(String text) {
    if (InvestmentType.stocks.contains(text)) {
      _displayInvestmentType = "STOCKS";
    } else if (InvestmentType.crypto.contains(text)) {
      _displayInvestmentType = "CRYPTO";
    } else {
      _displayInvestmentType = "FUNDS";
    }
  }

  void calculation(String text) {
    _displayTotalPrice = _displayPrice != '' && _displayQuantity != ''
        ? (double.parse(_displayPrice) * double.parse(_displayQuantity))
            .toString()
        : text;
    _displayCommission =
        text != '' ? (double.parse(_displayTotalPrice) * 2).toString() : text;
    _displayVat = text != ''
        ? (double.parse(_displayCommission) * 0.07).toString()
        : text;
    _displayTotalAmount = text != ''
        ? (double.parse(_displayTotalPrice) +
                double.parse(_displayCommission) +
                double.parse(_displayVat))
            .toString()
        : text;
  }

  void clearForm(TextEditingController fieldText) {
    fieldText.clear();
    fieldText.text = '';
  }

  Key get getPriceKey => UniqueKey();
  Key get getQuantityKey => UniqueKey();
  Key get getInvestmentTypeKey => UniqueKey();
  Key get getTotalPriceKey => UniqueKey();
  Key get getCommissionKey => UniqueKey();
  Key get getVatKey => UniqueKey();
  Key get getTotalAmountKey => UniqueKey();
  String get getDisplayName => _displayName;
  String get getDisplayPrice => _displayPrice;
  String get getDisplayQuantity => _displayQuantity;
  String get getDisplayDate => _displayDate;
  String get getDisplayBrokerage => _displayBrokerage;
  String get getDisplayInvestmentType => _displayInvestmentType;
  String get getDisplayAccountNumber => _displayAccountNumber;
  String get getDisplayAction => _displayAction;
  String get getDisplayTotalPrice => _displayTotalPrice;
  String get getDisplayCommission => _displayCommission;
  String get getDisplayVat => _displayVat;
  String get getDisplayTotalAmount => _displayTotalAmount;
}
