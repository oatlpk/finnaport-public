import 'package:animations/animations.dart';
import 'package:finnaport/config/config.dart';
import 'package:finnaport/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/models/models.dart';

class ListWidget extends StatefulWidget {
  final String category;
  ListWidget({this.category});

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<Article> articles = [];
  List<CategoryModel> categories = [];

  bool _loading = true;

  void getCategoryNews() async {
    CategoryNews newsClass = CategoryNews();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    _loading = true;
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  @override
  Widget build(BuildContext context) {
    final transitionType = ContainerTransitionType.fade;

    return _loading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Container(
                child: ListView.builder(
                  itemCount: articles.length,
                  itemBuilder: (context, index) =>
                      customListTile(articles[index], context),
                ),
              ),
            ),
          );
  }

  Widget customListTile(Article article, BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticlesPage(
              article: article,
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 130.0,
            width: screenSize.width - 16.0,
            decoration: BoxDecoration(
              color: Palette.finnaDarkBox,
              borderRadius: BorderRadius.circular(14.0),
              boxShadow: [
                BoxShadow(
                  color: Palette.finnaDropShadow.withOpacity(0.50),
                  blurRadius: 4,
                  offset: Offset(0, 4), // changes position of shadow
                ),
              ],
              image: DecorationImage(
                image: NetworkImage(article.urlToImage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                width: (screenSize.width - 16.0) / 2,
                height: 130.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13.0),
                  gradient: LinearGradient(
                    colors: [
                      Palette.finnaBoxShadow,
                      Palette.finnaBoxShadow.withOpacity(0.8),
                      Colors.black.withOpacity(0),
                    ],
                    end: Alignment.centerRight,
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(12.0, 4.0, 0.0, 0.0),
                            child: Text(article.title,
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.75),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
