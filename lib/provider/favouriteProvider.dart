import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:news_application/news/model/categories_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteNewsProvider extends ChangeNotifier {
  Set<Articles> _favorites = {};
    static const String _keyFavorites = 'favorites';


  Set<Articles> get favorites => _favorites;

  FavoriteNewsProvider() {
    loadFavorites();
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_keyFavorites);
    if (jsonString != null) {
      final Iterable decoded = jsonDecode(jsonString);
      _favorites = decoded.map((e) => Articles.fromJson(e)).toSet();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_favorites.toList());
    await prefs.setString(_keyFavorites, jsonString);
  }



  void addToFavorites(Articles news) {
    _favorites.add(news);
    _saveFavorites();
    notifyListeners();
  }

  void removeFromFavorites(Articles news) {
    _favorites.remove(news);
    _saveFavorites();
    notifyListeners();
  }

}
