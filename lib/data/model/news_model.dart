class NewsModel {
  String? status;
  int? totalResults;
  List<Articles>? articles;
  @override
  String toString() {
    return "status:$status, totalResults: $totalResults, articles: $articles)";
  }

  NewsModel({
    required this.status,
    required this.totalResults,
    this.articles,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      totalResults: json['totalResults'],
      articles: json['articles'] == null
          ? null
          : (json['articles'] as List<dynamic>)
              .map((e) => Articles.fromJson(e))
              .toList(),
    );
  }
}

class Articles {
  Source? source;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  Articles({
    this.source,
    this.author,
    this.title,
    this.urlToImage,
    this.content,
    this.description,
    this.publishedAt,
    this.url,
  });
  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      source: json['source'] == null ? null : Source.fromJson(json['source']),
      author: json['author'],
      title: json['title'],
      urlToImage: json['urlToImage'],
      content: json['content'],
      description: json['description'],
      publishedAt: json['publishedAt'],
      url: json['url'],
    );
  }
}
class Source {
  String? id;
  String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json){
    return Source(
      id: json['id'],
      name: json['name']
    );
  }
}