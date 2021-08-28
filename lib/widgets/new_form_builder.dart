import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:finnaport/config/config.dart';
import 'package:finnaport/models/for_typeahead/typeahead_list.dart';
import 'package:finnaport/provider/holdings_provider.dart';
import 'package:finnaport/provider/performance_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewFormBuilder extends StatelessWidget {
  final String buttonName;
  final String title;
  final String price;
  final String quantity;
  final String date;
  final String brokerage;
  final String investmentType;
  final String accountNumber;
  final String action;
  final String totalPrice;
  final String commission;
  final String vat;
  final String totalAmount;
  final String id;
  NewFormBuilder(
    BuildContext context, {
    Key key,
    this.buttonName = '',
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
  }) : super(key: key) {
    final holdingProvider =
        Provider.of<HoldingsProvider>(context, listen: false);
    holdingProvider.setDisplayPriceNoListen(price);
    holdingProvider.setDisplayQuantityNoListen(quantity);
    holdingProvider.setDisplayInvestmentTypeNoListen(investmentType);
    holdingProvider.setDisplayTotalPriceNoListen(totalPrice);
    holdingProvider.setDisplayCommissionNoListen(commission);
    holdingProvider.setDisplayVatNoListen(vat);
    holdingProvider.setDisplayTotalAmountNoListen(totalAmount);
  }

  static final List<String> itemsBrokerage = <String>[
    "SCB",
    "KRNGSI",
    "KBANK",
  ];

  static final List<String> itemsInvestType = <String>[
    "FUNDS",
    "STOCKS",
    "CRYPTO"
  ];

  static final List<String> itemsAction = <String>[
    "BUY",
    "SELL",
  ];

  var _formKey = GlobalKey<FormBuilderState>();
  final controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("create add holding screen from build");

    final Size screenSize = MediaQuery.of(context).size;
    final holdingClass = Provider.of<HoldingsProvider>(context);
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: true);
    String tempTitle = title;

    return SingleChildScrollView(
      child: Center(
        child: Form(
          key: _formKey,
          child: Container(
            width: screenSize.width - 16.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Consumer<HoldingsProvider>(
                  builder: (context, holdingClass, child) {
                    return TypeAheadFormField<String>(
                      textFieldConfiguration: TextFieldConfiguration(
                        enableSuggestions: true,
                        controller: tempTitle != ''
                            ? (controllerName..text = tempTitle)
                            : controllerName
                          ..text,
                        style: TextStyle(color: Palette.finnaWhiteText),
                        decoration: baseInputFieldDecoration(
                            label: 'Name', hint: 'TSLA / BTC'),
                      ),
                      suggestionsCallback: InvestmentType.getInvestmentTypeList,
                      itemBuilder: (context, String suggestion) => Container(
                        color: Palette.finnaDarkBox,
                        child: ListTile(
                          title: Text(
                            suggestion,
                            style: TextStyle(color: Palette.finnaWhiteText),
                          ),
                        ),
                      ),
                      onSuggestionSelected: (String suggestion) {
                        holdingClass.setDisplayName(suggestion.toString());
                        controllerName.text = suggestion;
                        tempTitle = suggestion;
                      },
                      validator: (value) => value != null && value.isEmpty
                          ? 'Please select a city'
                          : null,
                    );
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: price,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration:
                      baseInputFieldDecoration(label: 'Price', hint: '10.0'),
                  onChanged: (changed) => holdingClass.setDisplayPrice(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: quantity,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration:
                      baseInputFieldDecoration(label: 'Quantity', hint: '10.0'),
                  onChanged: (changed) =>
                      holdingClass.setDisplayQuantity(changed),
                ),
                SizedBox(height: 10),
                DateTimeField(
                  resetIcon: null,
                  readOnly: true,
                  initialValue: date.isEmpty
                      ? null
                      : DateFormat('dd/MM/yyyy').parse(date),
                  format: DateFormat('dd/MM/yyyy'),
                  onChanged: (changed) => holdingClass.setDisplayDate(changed),
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                    label: 'Date',
                    icon: Icon(Icons.calendar_today, color: Colors.grey),
                  ),
                  onShowPicker: (context, currentValue) {
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                ),
                SizedBox(height: 10),
                Container(
                  height: 58,
                  child: FormBuilderDropdown(
                    initialValue: brokerage.isEmpty ? null : brokerage,
                    name: 'Brokerage',
                    style: TextStyle(color: Palette.finnaWhiteText),
                    dropdownColor: Palette.finnaDarkBox,
                    iconEnabledColor: Palette.finnaGreen,
                    iconDisabledColor: Palette.finnaGreen,
                    decoration: baseInputFieldDecoration(label: 'Brokerage'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: itemsBrokerage
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text('$item'),
                          ),
                        )
                        .toList(),
                    onChanged: (changed) =>
                        holdingClass.setDisplayBrokerage(changed.toString()),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  height: 58,
                  child: FormBuilderDropdown(
                    initialValue: action.isEmpty ? null : action,
                    name: 'Action',
                    style: TextStyle(color: Palette.finnaWhiteText),
                    dropdownColor: Palette.finnaDarkBox,
                    iconEnabledColor: Palette.finnaGreen,
                    iconDisabledColor: Palette.finnaGreen,
                    decoration: baseInputFieldDecoration(label: 'Action'),
                    validator: FormBuilderValidators.compose(
                        [FormBuilderValidators.required(context)]),
                    items: itemsAction
                        .map(
                          (item) => DropdownMenuItem(
                            value: item,
                            child: Text('$item'),
                          ),
                        )
                        .toList(),
                    onChanged: (changed) =>
                        holdingClass.setDisplayAction(changed.toString()),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  initialValue: accountNumber,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                      label: 'Account No.', hint: '1111111111'),
                  onChanged: (changed) =>
                      holdingClass.setDisplayAccountNumber(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  key: holdingClass.getInvestmentTypeKey,
                  initialValue: holdingClass.getDisplayInvestmentType,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                      label: 'Type of Investment',
                      hint: "STOCKS / CRYPTO / FUNDS"),
                  onChanged: (changed) =>
                      holdingClass.setDisplayInvestmentType(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  key: holdingClass.getTotalPriceKey,
                  initialValue: holdingClass.getDisplayTotalPrice,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                      label: 'Total Price (Before Tax)', hint: '100.0'),
                  onChanged: (changed) =>
                      holdingClass.setDisplayTotalPrice(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  key: holdingClass.getCommissionKey,
                  initialValue: holdingClass.getDisplayCommission,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                      label: 'Commission', hint: '10.0'),
                  onChanged: (changed) =>
                      holdingClass.setDisplayCommission(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  key: holdingClass.getVatKey,
                  initialValue: holdingClass.getDisplayVat,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration:
                      baseInputFieldDecoration(label: 'Vat', hint: '10.0'),
                  onChanged: (changed) => holdingClass.setDisplayVat(changed),
                ),
                SizedBox(height: 10),
                TextFormField(
                  readOnly: true,
                  key: holdingClass.getTotalAmountKey,
                  initialValue: holdingClass.getDisplayTotalAmount,
                  keyboardType: TextInputType.number,
                  style: TextStyle(color: Palette.finnaWhiteText),
                  decoration: baseInputFieldDecoration(
                      label: 'Total Amount (After Tax)', hint: '1000.0'),
                  onChanged: (changed) =>
                      holdingClass.setDisplayTotalAmount(changed),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Palette.finnaGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                    ),
                    child: Text(
                      buttonName,
                      style: TextStyle(
                          color: Palette.finnaDarkBox,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      print("ID in form: " + id);
                      buttonName == "ADD HOLDING"
                          ? holdingClass.addHoldings(
                              holdingClass.getDisplayName,
                              holdingClass.getDisplayPrice,
                              holdingClass.getDisplayQuantity,
                              holdingClass.getDisplayDate,
                              holdingClass.getDisplayBrokerage,
                              holdingClass.getDisplayInvestmentType,
                              holdingClass.getDisplayAccountNumber,
                              holdingClass.getDisplayAction,
                              holdingClass.getDisplayTotalPrice,
                              holdingClass.getDisplayCommission,
                              holdingClass.getDisplayVat,
                              holdingClass.getDisplayTotalAmount,
                            )
                          : {
                              holdingClass.updateHoldings(
                                  holdingClass.getDisplayName,
                                  holdingClass.getDisplayPrice,
                                  holdingClass.getDisplayQuantity,
                                  holdingClass.getDisplayDate,
                                  holdingClass.getDisplayBrokerage,
                                  holdingClass.getDisplayInvestmentType,
                                  holdingClass.getDisplayAccountNumber,
                                  holdingClass.getDisplayAction,
                                  holdingClass.getDisplayTotalPrice,
                                  holdingClass.getDisplayCommission,
                                  holdingClass.getDisplayVat,
                                  holdingClass.getDisplayTotalAmount,
                                  id),
                              Navigator.of(context).pop(),
                            };
                      performanceProvider.getChartDataFromServer();
                    },
                  ),
                ),
                SizedBox(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
