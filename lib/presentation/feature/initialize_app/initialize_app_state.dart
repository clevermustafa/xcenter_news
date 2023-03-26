part of 'initialize_app_cubit.dart';

enum InitializeAppStatus {
  loading,
  loaded,
  error,
}

class InitializeAppState {
  final String? errorMessage;
  final InitializeAppStatus status;

  InitializeAppState({this.status = InitializeAppStatus.loading, this.errorMessage});

  InitializeAppState copyWith({InitializeAppStatus? status, String? errorMessage}){
    return InitializeAppState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }
}
