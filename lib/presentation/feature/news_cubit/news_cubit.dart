
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:xcenter_news/data/model/news_model.dart';
import 'package:xcenter_news/domain/use_cases/news/get_news_by_category_usecase.dart';
part 'news_state.dart';

@lazySingleton
class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.getNewsByCategoryUsecase) : super(const NewsState());
  final GetNewsByCategoryUsecase getNewsByCategoryUsecase;

  void getNewsByCategory(String category) async {
    emit(state.copyWith(status: NewsStatus.initial));
    
    final result = await getNewsByCategoryUsecase.call(category);
    return result.fold(
      (l) => emit(
        state.copyWith(failureMessage: l.failureMessage, status: NewsStatus.error),
      ),
      (r) => emit(state.copyWith(newsModel: r, status: NewsStatus.success)),
    );
  }
}
