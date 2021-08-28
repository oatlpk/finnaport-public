import 'package:finnaport/models/for_news/article_model.dart';
import 'package:flutter/material.dart';
import 'package:finnaport/config/config.dart';

class ArticlesPage extends StatelessWidget {
  final Article article;

  const ArticlesPage({this.article});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false, to not go back to previous page
        backgroundColor: Palette.background,
        centerTitle: true,
        title: Text(
          "NEWS FEED",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Palette.finnaGreen,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Container(
                    height: 300,
                    width: screenSize.width - 16.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(article.urlToImage),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                Container(
                  width: screenSize.width - 16.0,
                  decoration: baseBackgroundDecoration,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          article.title,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Colors.white.withOpacity(0.85),
                                fontSize: 30,
                              ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              article.publishedAt,
                              style: TextStyle(
                                color: Colors.white60,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        Text(
                          article.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
