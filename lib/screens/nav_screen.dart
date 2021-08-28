import 'package:finnaport/provider/holdings_provider.dart';
import 'package:finnaport/provider/nav_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';
import 'package:provider/provider.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    {
      print("create nav screen from constructor");
      context.read<HoldingsProvider>().fetchHoldingsFromFirestore();
    }
    return Consumer<NavBarProvider>(
      builder: (context, navBar, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: navBar.currentScreen,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Palette.finnaGreen,
          child: Icon(
            Icons.add,
            color: Palette.background,
          ),
          onPressed: () => navBar.currentTab = 2,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Palette.finnaDropShadow.withOpacity(0.50),
                blurRadius: 4,
                offset: Offset(0, -4), // changes position of shadow
              ),
            ],
          ),
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            color: Palette.finnaDarkBox,
            notchMargin: 7,
            child: Container(
              height: 50,
              margin: EdgeInsets.only(left: 12.0, right: 12.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      navBar.currentTab = 0;
                    },
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.dashboard,
                      color: navBar.currentTab == 0
                          ? Palette.finnaGreen
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      navBar.currentTab = 1;
                    },
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.book,
                      color: navBar.currentTab == 1
                          ? Palette.finnaGreen
                          : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  IconButton(
                    onPressed: () {
                      navBar.currentTab = 3;
                    },
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.auto_graph,
                      color: navBar.currentTab == 3
                          ? Palette.finnaGreen
                          : Colors.grey,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      navBar.currentTab = 4;
                    },
                    iconSize: 30.0,
                    icon: Icon(
                      Icons.attach_money_outlined,
                      color: navBar.currentTab == 4
                          ? Palette.finnaGreen
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
