import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:xcenter_news/data/data_source/app_config_data_source/app_config_data_source.dart';

part 'initialize_app_state.dart';

@lazySingleton
class InitializeAppCubit extends Cubit<InitializeAppState> {
  InitializeAppCubit(this.appConfigDataSource) : super(InitializeAppState());
  final AppConfigDataSource appConfigDataSource;

  Future<void> getApiKey() async {
    emit(state.copyWith(status: InitializeAppStatus.loading));
    String? apiKeyFromLocal =
        await appConfigDataSource.getNewsApiKeyFromLocal();
    if (apiKeyFromLocal == null) {
      /// this method gets api key from firestore and saves it locally in shared preference.
      final apiKeyFromFirebase = await appConfigDataSource.getNewsApiKey();
      apiKeyFromFirebase.fold(
        (l) => emit(
          state.copyWith(
              status: InitializeAppStatus.error,
              errorMessage: l.failureMessage),
        ),
        (r) => emit(
          state.copyWith(
            status: InitializeAppStatus.loaded,
          ),
        ),
      );
    } else {
      emit(state.copyWith(status: InitializeAppStatus.loaded));
    }
  }
}
