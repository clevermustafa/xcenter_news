import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:xcenter_news/core/error/failures.dart';
import 'package:xcenter_news/core/network/network_info.dart';
import 'package:xcenter_news/data/data_source/app_config_data_source/app_config_data_source.dart';
import 'package:xcenter_news/data/data_source/news_data_source/news_remote_data_source.dart';
import 'package:xcenter_news/data/model/news_model.dart';

import '../../domain/repository/news_repository.dart';
@LazySingleton(as: NewsRepository)
class NewsRepositoryImpl implements NewsRepository {
  final NetworkInfo networkInfo;
  NewsRemoteDataSource newsRemoteDataSource;
  AppConfigDataSource appConfigDataSource;
  NewsRepositoryImpl(this.networkInfo, this.newsRemoteDataSource, this.appConfigDataSource);

  @override
  Future<Either<Failure, NewsModel>> getNewsByCategory(String category) async {
    if (await networkInfo.isConnected) {
      try {
        final apiKey = await appConfigDataSource.getNewsApiKeyFromLocal();
        final data = await newsRemoteDataSource.getNewsByCategory(category, apiKey!);
        return Right(data);
      } catch (e) {
        return Left(parseFailure(e));
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
