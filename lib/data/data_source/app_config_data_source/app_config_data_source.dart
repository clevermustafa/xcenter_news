import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcenter_news/core/network/network_info.dart';
import 'package:xcenter_news/core/resources/app_strings.dart';
import '../../../core/error/failures.dart';

abstract class AppConfigDataSource {
  Future<Either<Failure, String>> getNewsApiKey();
  Future<String?> getNewsApiKeyFromLocal();
}
@LazySingleton(as: AppConfigDataSource)
class AppConfigDataSourceImpl implements AppConfigDataSource {
  FirebaseFirestore firestore;
  SharedPreferences sharedPreferences;
  NetworkInfo networkInfo;
  AppConfigDataSourceImpl(this.firestore, this.sharedPreferences, this.networkInfo);
  @override
  Future<Either<Failure, String>> getNewsApiKey() async {
    if(await networkInfo.isConnected) {
          final result =  await firestore.collection(AppStrings.keyCollection).get();
    final data = result.docs[0].data();
    final newsApiKey = data[AppStrings.apiKeyPrefs];
    saveNewsApiKeyLocally(newsApiKey);
    return Right(newsApiKey);
    } else {
      return Left(NetworkFailure());
    }

  }
  
  @override
  Future<String?> getNewsApiKeyFromLocal() async {
    return sharedPreferences.getString(AppStrings.apiKeyPrefs);
  }
  
  Future<void> saveNewsApiKeyLocally(String key) async {
    await sharedPreferences.setString(AppStrings.apiKeyPrefs, key);
  }
}