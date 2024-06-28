import 'package:flutter/material.dart';
import 'package:news_application/services/firestore_services.dart';

class NewsPage extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: StreamBuilder<List<NewsArticle>>(
        stream: _firestoreService.getNewsArticles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No news articles available'));
          }
          List<NewsArticle> articles = snapshot.data!;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              NewsArticle article = articles[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(article.imageUrl),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(article.newsTitle, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(article.newsDescription),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
