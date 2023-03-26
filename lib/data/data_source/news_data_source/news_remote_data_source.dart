import 'package:injectable/injectable.dart';
import 'package:xcenter_news/core/error/exceptions.dart';
import 'package:xcenter_news/core/network/network_utils.dart';

import '../../../core/resources/app_url.dart';
import '../../model/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getNewsByCategory(String category, String apiKey);
}
@LazySingleton(as: NewsRemoteDataSource)
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  NetworkUtil networkUtil;
  NewsRemoteDataSourceImpl(this.networkUtil);
  @override
  Future<NewsModel> getNewsByCategory(String category, String apiKey) async {
    try {
      final response = await networkUtil.get("${AppUrl.baseUrl}${AppUrl.category}$category&apiKey=$apiKey");
      return NewsModel.fromJson(networkUtil.parseNormalResponse(response));
    } catch (e) {
      throw throwException(e);
    }
  }
}