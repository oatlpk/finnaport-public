import 'package:finnaport/models/for_news/article_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class News {
  List<Article> news = [];

  Future<void> getNews() async {
    String url =
        //api here

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: element['publishedAt'],
              content: element["content"],
            );
            news.add(article);
          }
        },
      );
    }
  }
}

class CategoryNews {
  List<Article> news = [];

  Future<void> getNews(String category) async {
    String url =
        //api here

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach(
        (element) {
          if (element['urlToImage'] != null && element['description'] != null) {
            Article article = Article(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              urlToImage: element['urlToImage'],
              publishedAt: element['publishedAt'],
              content: element["content"],
            );
            news.add(article);
          }
        },
      );
    }
  }
}
