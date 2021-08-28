import 'package:finnaport/models/for_typeahead/typeahead_list.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/widgets/widgets.dart';

class LiveMarket extends StatelessWidget {
  const LiveMarket({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: appBarBuilder(context: context, pageTitle: "LIVE MARKET"),
        body: TabBarView(
          children: [
            GridWidget(symbolList: InvestmentType.funds),
            GridWidget(symbolList: InvestmentType.stocks),
            GridWidget(symbolList: InvestmentType.crypto),
          ],
        ),
      ),
    );
  }
}
