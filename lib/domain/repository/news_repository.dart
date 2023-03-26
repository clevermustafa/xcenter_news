import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../../data/model/news_model.dart';

abstract class NewsRepository {
  Future<Either<Failure, NewsModel>> getNewsByCategory(String category);
}