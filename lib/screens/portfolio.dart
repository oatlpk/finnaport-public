import 'package:finnaport/provider/performance_provider.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';

class Portfolio extends StatelessWidget {
  Portfolio({Key key}) : super(key: key) {
    print("create portfolio screen from constructor");
  }

  @override
  Widget build(BuildContext context) {
    final performanceProvider =
        Provider.of<PerformanceProvider>(context, listen: false);
    print("create portfolio screen from build");
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Palette.background,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "PERFORMANCE",
              style: TextStyle(
                fontSize: 26.0,
                fontWeight: FontWeight.bold,
                color: Palette.finnaGreen,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.info_outline),
            color: Palette.finnaGreen,
            onPressed: () {
              showMaterialDialog(context);
            },
          ),
        ],
        bottom: PreferredSize(
            child: Container(
              height: 30,
              child: Column(
                children: <Widget>[
                  Text(
                    "Saran Lertprasertkong Portfolio",
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Palette.finnaGold,
                    ),
                  ),
                ],
              ),
            ),
            preferredSize: Size.fromHeight(4.0)),
      ),
      body: FutureBuilder(
        future: performanceProvider.getChartDataFromServer(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  FlipCard(
                    direction: FlipDirection.HORIZONTAL,
                    front: SyncfusionLineChartPortfolio(),
                    back: Container(
                      height: 300,
                      width: screenSize.width - 16.0,
                      decoration: baseBackgroundDecoration,
                      child: Text(
                        "hi",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0, bottom: 5.0),
                    child: Container(
                      width: screenSize.width - 16.0,
                      child: Row(
                        children: [
                          buildPortfolioHeadings("Summary  ", 20),
                        ],
                      ),
                    ),
                  ),
                  SummaryText(),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Container(
                      width: screenSize.width - 16.0,
                      child: buildPortfolioHeadings("Your Holdings", 20),
                    ),
                  ),
                  ExpandingTile(),
                  SizedBox(height: 5),
                ],
              ),
            );
          } else {
            return Center(child: Container(child: CircularProgressIndicator()));
          }
        },
      ),
    );
  }

  Widget buildPortfolioHeadings(String heading, double size) => Text(
        heading,
        style: TextStyle(
          color: Palette.finnaGreenText,
          fontSize: size,
          fontWeight: FontWeight.w700,
        ),
      );
  void showMaterialDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        elevation: 3,
        backgroundColor: Palette.finnaDarkBox,
        title: Text(
          "Please Select Import Option",
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
          ),
        ),
        content: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.picture_as_pdf_outlined),
                    iconSize: 45,
                    color: Palette.finnaGreenText,
                    onPressed: () {},
                  ),
                  Text(
                    'PDF',
                    style: TextStyle(
                        color: Palette.finnaGreenText,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.table_view_outlined),
                    iconSize: 45,
                    color: Palette.finnaGreenText,
                    onPressed: () {},
                  ),
                  Text(
                    'CSV',
                    style: TextStyle(
                        color: Palette.finnaGreenText,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
