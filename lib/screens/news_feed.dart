import 'package:finnaport/models/models.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/widgets/widgets.dart';

class NewsFeed extends StatelessWidget {
  final List<CategoryModel> categories = [];
  NewsFeed({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: NavigationDrawerWidget(),
        appBar: appBarBuilder(context: context, pageTitle: "NEWS FEED"),
        body: TabBarView(
          children: [
            ListWidget(category: 'Business'),
            ListWidget(category: 'Entertainment'),
            ListWidget(category: 'General'),
          ],
        ),
      ),
    );
  }
}
