import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_holdings/holdings_model_provider.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';

class EditHolding extends StatelessWidget {
  final HoldingsClass holdings;
  const EditHolding({Key key, @required this.holdings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.finnaDarkBox,
        centerTitle: true,
        title: Text(
          "EDIT HOLDING",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Palette.finnaGreen,
          ),
        ),
      ),
      body: NewFormBuilder(
        context,
        buttonName: "CONFIRM UPDATE",
        title: holdings.title,
        price: holdings.price,
        quantity: holdings.quantity,
        date: holdings.date,
        brokerage: holdings.brokerage,
        investmentType: holdings.investmentType,
        accountNumber: holdings.accountNumber,
        action: holdings.action,
        totalPrice: holdings.totalPrice,
        commission: holdings.commission,
        vat: holdings.vat,
        totalAmount: holdings.totalAmount,
        id: holdings.id,
      ),
    );
  }
}
