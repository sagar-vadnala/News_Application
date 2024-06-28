import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:news_application/components/my_drawer.dart';
import 'package:news_application/news/news_headline_model.dart';
import 'package:news_application/news/model/news_view_model.dart';
import 'package:news_application/pages/Categories_page.dart';
import 'package:news_application/pages/favourite_page.dart';
import 'package:news_application/pages/news_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum FilterList { bbcNews, independent, reuters, espn, cnn, cryptocoinsews }

class _HomeScreenState extends State<HomeScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM, dd, yyyy");
  FilterList? selectedMenu;
  String name = 'bbc-news';
  String categoryName = 'general';

  //final FavoriteManager favoriteManager = FavoriteManager();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "N E W S ",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoriteNewsScreen(favoriteNewsList: [],),
                ),
              );
            },
          ),
          PopupMenuButton<FilterList>(
              initialValue: selectedMenu,
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).colorScheme.primary,
              ),
              onSelected: (FilterList item) {
                if (FilterList.espn.name == item.name) {
                  name = 'ESPN';
                }
                if (FilterList.bbcNews.name == item.name) {
                  name == 'bbc-news';
                }
                if (FilterList.cnn.name == item.name) {
                  name = 'cnn';
                }
                setState(() {
                  selectedMenu = item;
                });
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.espn,
                      child: Text("ESPN"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text("BBc News"),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.cnn,
                      child: Text("CNN"),
                    ),
                  ])
        ],
      ),
      drawer: const MyDrawer(),
      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: height * 0.4,
                    width: width,
                    child: FutureBuilder<NewsChannelsHeadlinesModel>(
                      future:
                          NewsViewModel().fetchNewsChannelHeadlinesApi(name),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Top Headlines",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.articles!.length,
                                  itemBuilder: (context, index) {
                                    DateTime dateTime = DateTime.parse(snapshot
                                        .data!.articles![index].publishedAt
                                        .toString());
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewsDetails(
                                                newsImage: snapshot.data!
                                                    .articles![index].urlToImage
                                                    .toString(),
                                                newsTitle: snapshot.data!
                                                    .articles![index].title
                                                    .toString(),
                                                newsDate: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .publishedAt
                                                    .toString(),
                                                author: snapshot.data!
                                                    .articles![index].author
                                                    .toString(),
                                                description: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .description
                                                    .toString(),
                                                context: snapshot.data!
                                                    .articles![index].content
                                                    .toString(),
                                                source: snapshot
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                              ),
                                            ));
                                      },
                                      child: SizedBox(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(
                                              height: height * 0.6,
                                              width: width * 0.9,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.02),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: CachedNetworkImage(
                                                  imageUrl: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    child: spinKit2,
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          const Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 20,
                                              child: Card(
                                                elevation: 5,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .inversePrimary,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                ),
                                                child: Container(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  height: height * 0.14,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10, right: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: width * 0.7,
                                                        child: Text(
                                                          snapshot
                                                              .data!
                                                              .articles![index]
                                                              .title
                                                              .toString(),
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 17,
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      SizedBox(
                                                        width: width * 0.7,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                snapshot
                                                                    .data!
                                                                    .articles![
                                                                        index]
                                                                    .source!
                                                                    .name
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .colorScheme
                                                                        .primary),
                                                              ),
                                                            ),
                                                            Text(
                                                              format.format(
                                                                  dateTime),
                                                              style: TextStyle(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        } else {
                          // No data available
                          return const Center(
                            child: Text("No data available"),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),

            ////////////////// GENERAL NEWS
            const CategoriesPage(),
          ],
        ),
      ),
    );
  }
}

const spinKit2 = SpinKitCircle(
  color: Colors.blue,
  size: 50,
);
