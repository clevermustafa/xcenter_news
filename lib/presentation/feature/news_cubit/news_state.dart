part of 'news_cubit.dart';

enum NewsStatus {
  initial,
  success,
  error,
}

class NewsState{
  final NewsStatus status;
  final String? failureMessage;
  final NewsModel? newsModel;

  const NewsState({
    this.status = NewsStatus.initial,
    this.failureMessage,
    this.newsModel
  });

  NewsState copyWith({NewsStatus? status, String? failureMessage, NewsModel? newsModel}) {
    return NewsState(
      status: status ?? this.status,
      failureMessage: failureMessage ?? this.failureMessage,
      newsModel: newsModel ?? this.newsModel,
    );
  }

}
