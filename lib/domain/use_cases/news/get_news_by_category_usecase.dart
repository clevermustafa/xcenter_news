import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:xcenter_news/core/use_cases/use_cases.dart';
import 'package:xcenter_news/data/model/news_model.dart';
import 'package:xcenter_news/domain/repository/news_repository.dart';

import '../../../core/error/failures.dart';

abstract class GetNewsByCategoryUsecase implements UseCases<Either<Failure, NewsModel>, String> {}

@LazySingleton(as: GetNewsByCategoryUsecase)
class GetNewsByCategoryUsecaseImpl implements GetNewsByCategoryUsecase {
  NewsRepository newsRepository;
  GetNewsByCategoryUsecaseImpl(this.newsRepository);
  
  @override
  Future<Either<Failure, NewsModel>> call(String params) {
    return newsRepository.getNewsByCategory(params);
  }

}