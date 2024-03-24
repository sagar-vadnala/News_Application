// import 'package:flutter/material.dart';
// import 'package:news_application/widgets/news_item.dart';

// class FavoriteManager extends ChangeNotifier {
//   List<NewsItem> _favoriteNewsList = [];

//   List<NewsItem> get favoriteNewsList => _favoriteNewsList;

//   void addToFavorites(NewsItem newsItem) {
//     _favoriteNewsList.add(newsItem);
//     notifyListeners(); // Notify listeners when favorites change
//   }

//   void removeFromFavorites(NewsItem newsItem) {
//     _favoriteNewsList.remove(newsItem);
//     notifyListeners(); // Notify listeners when favorites change
//   }

//   bool isFavorite(NewsItem newsItem) {
//     return _favoriteNewsList.contains(newsItem);
//   }

//   void toggleFavorite(NewsItem newsItem) {
//     if (isFavorite(newsItem)) {
//       removeFromFavorites(newsItem);
//     } else {
//       addToFavorites(newsItem);
//     }
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:news_application/models/article.dart';
// import 'package:news_application/news/model/categories_model.dart';

// class FavoriteNewsProvider extends ChangeNotifier {
//   List<Articles> _favoriteNews = [];

//   List<Articles> get favoriteNews => _favoriteNews;

//   void addToFavorite(Articles article) {
//     _favoriteNews.add(article);
//     notifyListeners();
//   }

//   void removeFromFavorite(Articles article) {
//     _favoriteNews.remove(article);
//     notifyListeners();
//   }
// }

