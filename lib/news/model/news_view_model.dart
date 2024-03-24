import 'package:news_application/news/model/categories_model.dart';
import 'package:news_application/news/news_headline_model.dart';
import 'package:news_application/news/news_repo.dart';

class NewsViewModel {
  final NewsRepository _repository = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelHeadlinesApi(String channelName) async {
    // Pass channelName to the repository method
    return _repository.fetchNewChannelHeadlinesApi(channelName);
  }

  Future<CategoriesNewsModel> fetchCategoriesNewsApi(String category) async {
    // Pass channelName to the repository method
    return _repository.fetchCategoriesNewsApi(category);
  }
}
