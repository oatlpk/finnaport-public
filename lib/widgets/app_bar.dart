import 'package:finnaport/config/config.dart';
import 'package:finnaport/widgets/widgets.dart';
import 'package:flutter/material.dart';

AppBar appBarBuilder(
        {BuildContext context,
        TabController tabController,
        String pageTitle}) =>
    AppBar(
      //automaticallyImplyLeading: false, to not go back to previous page
      backgroundColor: Palette.finnaDarkBox,
      centerTitle: true,
      title: Text(
        pageTitle,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Palette.finnaGreenText,
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            color: Palette.finnaGreen,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }),
      ],
      bottom: TabBar(
        isScrollable: true,
        indicatorPadding: EdgeInsets.all(10),
        labelColor: Palette.finnaGold,
        unselectedLabelColor: Palette.finnaGreen,
        labelStyle: TextStyle(fontSize: 20),
        labelPadding: EdgeInsets.only(left: 35, right: 35, top: 10, bottom: 10),
        indicatorColor: Colors.white.withOpacity(0.0),
        controller: tabController,
        tabs: [
          Text('Funds'),
          Text('Stocks'),
          Text('Crypto'),
        ],
      ),
    );

AppBar appBarBuilderShort({BuildContext context, String pageTitle}) => AppBar(
      backgroundColor: Palette.finnaDarkBox,
      centerTitle: true,
      title: Text(
        pageTitle,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
          color: Palette.finnaGreen,
        ),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.search),
            color: Palette.finnaGreen,
            onPressed: () {
              showSearch(context: context, delegate: DataSearch());
            }),
      ],
    );
