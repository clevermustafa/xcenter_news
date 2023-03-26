import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xcenter_news/core/dependency_injection/di.dart';
import 'package:xcenter_news/core/resources/constants.dart';
import 'package:xcenter_news/core/utils/notification_service.dart';
import 'package:xcenter_news/core/utils/toast_utils.dart';
import 'package:xcenter_news/data/data_source/notification_remote_data_source.dart';
import 'package:xcenter_news/data/model/news_model.dart';
import 'package:xcenter_news/presentation/feature/news_cubit/news_cubit.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late NewsCubit newsCubit;
  late NotificationService notificationService;

  @override
  void initState() {
    newsCubit = getIt.get<NewsCubit>();
    newsCubit.getNewsByCategory('Business');
    notificationService = NotificationService();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');
      AndroidNotification? androidNotification = message.notification?.android;
      if (message.notification != null && androidNotification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
        notificationService.showNotification(message);
      }
    });
    super.initState();
  }

  int _selectedTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("News App"),
        actions: [
          InkWell(
              onTap: () async {
                await getIt
                    .get<NotificationRemoteDataSource>()
                    .sendNotification();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.notifications),
              ))
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 40,
            child: ListView.separated(
              padding: const EdgeInsets.only(left: 5, right: 5),
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(width: 5),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedTab = index;
                    });
                    newsCubit.getNewsByCategory(categories[_selectedTab]);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: index == _selectedTab
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceVariant,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      categories[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: index == _selectedTab
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: NewsBody(newsCubit: newsCubit),
          )
        ],
      ),
    );
  }
}

class NewsBody extends StatelessWidget {
  final NewsCubit newsCubit;
  const NewsBody({
    super.key,
    required this.newsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsState>(
      bloc: newsCubit,
      listener: (context, state) {
        if (state.status == NewsStatus.error) {
          ToastUtils.showToast(
            state.failureMessage ?? "Error",
            ToastType.ERROR,
          );
        }
      },
      builder: (context, state) {
        log(state.status.toString());
        return Stack(
          children: [
            state.newsModel != null
                ? LayoutBuilder(builder: (context, constrains) {
                  var size = MediaQuery.of(context).size;
                    if (constrains.maxWidth >= 480) {
                      return GridView.builder(
                          itemCount: state.newsModel!.articles!.length,
                          gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: (size.width/2)/100
                          ),
                          itemBuilder: (context, index) {
                            Articles article =
                                state.newsModel!.articles![index];
                            return Container(
                            
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Image.network(
                                    article.urlToImage ??
                                        "https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg",
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.source?.name ?? "No Source",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            article.title ?? "No title",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return ListView.separated(
                        itemCount: state.newsModel!.articles!.length,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemBuilder: (context, index) {
                          Articles article = state.newsModel!.articles![index];
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              height: 300,
                              width: double.infinity,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .surfaceVariant,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Image.network(
                                    article.urlToImage ??
                                        "https://thumbs.dreamstime.com/b/news-newspapers-folded-stacked-word-wooden-block-puzzle-dice-concept-newspaper-media-press-release-42301371.jpg",
                                    height: 200,
                                    width: MediaQuery.of(context).size.width,
                                    fit: BoxFit.cover,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.source?.name ?? "No Source",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                            ),
                                          ),
                                          Text(
                                            article.title ?? "No title",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  })
                : const Center(
                    child: Text("No News"),
                  ),
            state.status == NewsStatus.initial
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox()
          ],
        );
      },
    );
  }
}
