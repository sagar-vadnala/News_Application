import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<NewsArticle>> getNewsArticles() {
    return _db.collection('news').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => NewsArticle.fromFirestore(doc)).toList());
  }
}

class NewsArticle {
  final String imageUrl;
  final String newsTitle;
  final String newsDescription;

  NewsArticle({required this.imageUrl, required this.newsTitle, required this.newsDescription});

  factory NewsArticle.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return NewsArticle(
      imageUrl: data['imageUrl'] ?? '',
      newsTitle: data['newsTitle'] ?? '',
      newsDescription: data['newsDescription'] ?? '',
    );
  }
}
