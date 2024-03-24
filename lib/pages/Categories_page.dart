import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_application/news/model/categories_model.dart';
import 'package:news_application/news/model/news_view_model.dart';
import 'package:news_application/pages/home_screen.dart';
import 'package:news_application/pages/news_details_screen.dart';
import 'package:news_application/provider/favouriteProvider.dart';
import 'package:provider/provider.dart';

class CategoriesPage extends StatefulWidget {
  const CategoriesPage({super.key});

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  NewsViewModel newsViewModel = NewsViewModel();

  final format = DateFormat("MMMM, dd, yyyy");
  String categoryName = 'general';

  @override
  Widget build(BuildContext context) {
    final favoriteNewsProvider = Provider.of<FavoriteNewsProvider>(context);
    final height = MediaQuery.of(context).size.height;
    return Expanded(
      child: FutureBuilder<CategoriesNewsModel>(
        future: NewsViewModel().fetchCategoriesNewsApi(categoryName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SpinKitCircle(
                size: 50,
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            // Data loaded successfully
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.articles!.length,
              itemBuilder: (_, int index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    bottom: 5,
                  ),
                  child: Container(
                    height: height * 0.15,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(12),
                      //border: Border.all(color: Colors.grey.shade100)
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetails(
                                newsImage: snapshot
                                    .data!.articles![index].urlToImage
                                    .toString(),
                                newsTitle: snapshot.data!.articles![index].title
                                    .toString(),
                                newsDate: snapshot
                                    .data!.articles![index].publishedAt
                                    .toString(),
                                author: snapshot.data!.articles![index].author
                                    .toString(),
                                description: snapshot
                                    .data!.articles![index].description
                                    .toString(),
                                context: snapshot.data!.articles![index].content
                                    .toString(),
                                source: snapshot
                                    .data!.articles![index].source!.name
                                    .toString(),
                              ),
                            ));
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (snapshot.data!.articles![index].urlToImage !=
                              null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 5, left: 15, right: 15),
                                child: SizedBox(
                                  height: height * 0.10,
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot
                                        .data!.articles![index].urlToImage!,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      child: spinKit2,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(
                                      Icons.error,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 5,
                          ),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(top: 0),
                              height: height * 0.18,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        snapshot.data!.articles![index].title
                                            .toString(),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Articles news = snapshot.data!.articles![index];
                                favoriteNewsProvider.addToFavorites(news);
                                print(
                                    'this is the list: ${favoriteNewsProvider.favorites} ${news.content}');
                              },
                              icon: Icon(Icons.bookmark_outline_rounded))
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            // Handle the case when snapshot has no data
            return const Center(
              child: Text("No data available"),
            );
          }
        },
      ),
    );
  }
}





