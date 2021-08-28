import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // action for appbar
    return [
      IconButton(
        onPressed: () {},
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon Leading
    return IconButton(
      onPressed: () {},
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Result Search
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone search for something
    return Text("Body Search");
  }
}
