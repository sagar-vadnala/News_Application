import 'package:flutter/material.dart';
import 'package:news_application/news/model/categories_model.dart';
import 'package:news_application/provider/favouriteProvider.dart';
import 'package:news_application/widgets/news_item.dart';
import 'package:provider/provider.dart';

class FavoriteNewsScreen extends StatefulWidget {
  final List<NewsItem> favoriteNewsList;

  const FavoriteNewsScreen({Key? key, required this.favoriteNewsList}) : super(key: key);

  @override
  State<FavoriteNewsScreen> createState() => _FavoriteNewsScreenState();
}

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  
 _loadFavorites() {
   final favoriteNewsProvider =
        Provider.of<FavoriteNewsProvider>(context, listen: true).loadFavorites();
        
  }

   
  @override
  void initState() {
  //  _loadFavorites();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNewsProvider =
        Provider.of<FavoriteNewsProvider>(context, listen: true);

            List<Articles> favoritesList = favoriteNewsProvider.favorites.toList();


    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite News'),
      ),
      body: ListView.builder(
        itemCount: favoriteNewsProvider.favorites.length,
        itemBuilder: (context, index) {
          Articles article = favoritesList[index];
          return ListTile(
            title: Text(article.title??''),
            subtitle: Text(article.description??''),
            leading: Image.network(article.urlToImage??''),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:news_application/models/article.dart';
// import 'package:news_application/widgets/favorite_manager.dart';
// import 'package:provider/provider.dart';

// class FavoriteNewsScreen extends StatelessWidget {
//   const FavoriteNewsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Favorite News'),
//       ),
//       body: Consumer<FavoriteNewsProvider>(
//         builder: (context, favoriteNewsProvider, child) {
//           return GridView.builder(
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: favoriteNewsProvider.favoriteNews.length,
//             itemBuilder: (context, index) {
//               Article article = favoriteNewsProvider.favoriteNews[index];
//               return  Container();// Display the favorite news article
//             },
//           );
//         },
//       ),
//     );
//   }
// }
