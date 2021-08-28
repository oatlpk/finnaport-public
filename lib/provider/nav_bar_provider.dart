import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';

class NavBarProvider extends ChangeNotifier {
  int _currentTab = 0;
  List<Widget> _screens = [
    NewsFeed(),
    Portfolio(),
    AddHoldingsPage(),
    LiveMarket(),
    Settings()
  ];

  set currentTab(int tab) {
    this._currentTab = tab;
    notifyListeners();
  }

  get currentTab => this._currentTab;
  get currentScreen => this._screens[this._currentTab];
}
