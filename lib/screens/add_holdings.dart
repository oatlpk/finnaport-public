import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';
import 'package:finnaport/widgets/widgets.dart';

class AddHoldingsPage extends StatelessWidget {
  const AddHoldingsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerWidget(),
      appBar: AppBar(
        backgroundColor: Palette.finnaDarkBox,
        centerTitle: true,
        title: Text(
          "ADD HOLDINGS",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Palette.finnaGreen,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.upload_file_outlined),
            color: Palette.finnaGreen,
            onPressed: () {
              showMaterialDialog(context);
            },
          ),
        ],
      ),
      body: NewFormBuilder(
        context,
        buttonName: "ADD HOLDING",
      ),
    );
  }

  Widget buildText(String text, double fontSize) => Container(
        child: Text(
          text,
          style: TextStyle(
              color: Palette.finnaGreen,
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
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
