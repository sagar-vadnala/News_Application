import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_application/pages/favourite_page.dart';
import 'package:news_application/widgets/news_item.dart';

class NewsDetails extends StatefulWidget {
  final String newsImage,
      newsDate,
      newsTitle,
      author,
      description,
      context,
      source;
  const NewsDetails({
    super.key,
    required this.newsTitle,
    required this.newsDate,
    required this.author,
    required this.description,
    required this.context,
    required this.source,
    required this.newsImage,
  });

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  final format = DateFormat("MMMM, dd, yyyy");
  //FavoriteManager favoriteManager = FavoriteManager();
  @override
  Widget build(BuildContext context) {
    //final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    DateTime dateTime = DateTime.parse(widget.newsDate);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
      ),
      body: Stack(
        children: [
          SizedBox(
            height: height * 0.45,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newsImage,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          Container(
            height: height * 0.6,
            margin: EdgeInsets.only(top: height * 0.4),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.background,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(40),
              ),
            ),
            child: ListView(
              children: [
                Text(
                  widget.newsTitle,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.source,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      format.format(dateTime),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Add to your favourite list ---------------->"),
                    IconButton(
                      icon: const Icon(Icons.favorite),
                      onPressed: () {
                        
                        // // Create a NewsItem object
                        // NewsItem newsItem = NewsItem(
                        //   newsTitle: widget.newsTitle,
                        //   newsDate: widget.newsDate,
                        //   author: widget.author,
                        //   description: widget.description,
                        //   source: widget.source,
                        //   newsImage: widget.newsImage,
                        // );

                        // // Add the NewsItem to favorites
                        // favoriteManager.addToFavorites(newsItem);

                        // // Navigate to the favorite page
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => FavoriteNewsScreen(
                        //       favoriteNewsList:
                        //           [],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
