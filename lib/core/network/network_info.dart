

import 'package:injectable/injectable.dart';

import '../utils/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectionChecker);

  final DataConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
