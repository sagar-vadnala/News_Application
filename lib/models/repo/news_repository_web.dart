import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_application/models/article.dart';
import 'package:news_application/models/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPages extends StatefulWidget {
  const NewsPages({super.key});

  @override
  State<NewsPages> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPages> {
  final Dio dio = Dio();

  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News",
        ),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 5,bottom: 5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.inversePrimary,
              borderRadius: BorderRadius.circular(24),
                          //border: Border.all(color: Colors.grey.shade100)
            ),
            child: ListTile(
              onTap: () {
                _launchUrl(
                  Uri.parse(article.url ?? ""),
                );
              },
              leading: SizedBox(
                height: 250,
                  width: 100,
                child: Image.network(
                  article.urlToImage ?? PLACEHOLDER_IMAGE_LINK,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.no_adult_content_rounded,size: 50,);
                  },
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                article.title ?? "",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                article.source!.name ?? "",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _getNews() async {
    final response = await dio.get(
      'https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=${NEWS_API_KEY}',
    );
    final articlesJson = response.data["articles"] as List;
    setState(() {
      List<Article> newsArticle =
          articlesJson.map((a) => Article.fromJson(a)).toList();
      newsArticle = newsArticle.where((a) => a.title != "[Removed]").toList();
      articles = newsArticle;
    });
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}