import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xcenter_news/core/dependency_injection/di.config.dart';
import 'package:xcenter_news/core/utils/data_connection_checker.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init')
Future<void> configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();

  @lazySingleton
  DataConnectionChecker get dataConnectionChecker => DataConnectionChecker();

  @lazySingleton
  FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

  @preResolve
  Future<SharedPreferences> get sharedPreferences async=> await SharedPreferences.getInstance();
}
