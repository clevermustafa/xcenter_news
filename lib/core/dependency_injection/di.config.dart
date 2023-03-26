// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i10;
import 'package:xcenter_news/core/dependency_injection/di.dart' as _i17;
import 'package:xcenter_news/core/network/network_info.dart' as _i6;
import 'package:xcenter_news/core/network/network_utils.dart' as _i7;
import 'package:xcenter_news/core/utils/data_connection_checker.dart' as _i3;
import 'package:xcenter_news/data/data_source/app_config_data_source/app_config_data_source.dart'
    as _i11;
import 'package:xcenter_news/data/data_source/news_data_source/news_remote_data_source.dart'
    as _i8;
import 'package:xcenter_news/data/data_source/notification_remote_data_source.dart'
    as _i9;
import 'package:xcenter_news/data/repo_impl/news_repository_impl.dart' as _i14;
import 'package:xcenter_news/domain/repository/news_repository.dart' as _i13;
import 'package:xcenter_news/domain/use_cases/news/get_news_by_category_usecase.dart'
    as _i15;
import 'package:xcenter_news/presentation/feature/initialize_app/initialize_app_cubit.dart'
    as _i12;
import 'package:xcenter_news/presentation/feature/news_cubit/news_cubit.dart'
    as _i16; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i3.DataConnectionChecker>(
        () => registerModule.dataConnectionChecker);
    gh.lazySingleton<_i4.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i5.FirebaseFirestore>(
        () => registerModule.firebaseFirestore);
    gh.lazySingleton<_i6.NetworkInfo>(
        () => _i6.NetworkInfoImpl(gh<_i3.DataConnectionChecker>()));
    gh.lazySingleton<_i7.NetworkUtil>(
        () => _i7.NetworkUtil(dio: gh<_i4.Dio>()));
    gh.lazySingleton<_i8.NewsRemoteDataSource>(
        () => _i8.NewsRemoteDataSourceImpl(gh<_i7.NetworkUtil>()));
    gh.lazySingleton<_i9.NotificationRemoteDataSource>(
        () => _i9.NotificationRemoteDataSourceImpl(gh<_i7.NetworkUtil>()));
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => registerModule.sharedPreferences,
      preResolve: true,
    );
    gh.lazySingleton<_i11.AppConfigDataSource>(
        () => _i11.AppConfigDataSourceImpl(
              gh<_i5.FirebaseFirestore>(),
              gh<_i10.SharedPreferences>(),
              gh<_i6.NetworkInfo>(),
            ));
    gh.lazySingleton<_i12.InitializeAppCubit>(
        () => _i12.InitializeAppCubit(gh<_i11.AppConfigDataSource>()));
    gh.lazySingleton<_i13.NewsRepository>(() => _i14.NewsRepositoryImpl(
          gh<_i6.NetworkInfo>(),
          gh<_i8.NewsRemoteDataSource>(),
          gh<_i11.AppConfigDataSource>(),
        ));
    gh.lazySingleton<_i15.GetNewsByCategoryUsecase>(
        () => _i15.GetNewsByCategoryUsecaseImpl(gh<_i13.NewsRepository>()));
    gh.lazySingleton<_i16.NewsCubit>(
        () => _i16.NewsCubit(gh<_i15.GetNewsByCategoryUsecase>()));
    return this;
  }
}

class _$RegisterModule extends _i17.RegisterModule {}
