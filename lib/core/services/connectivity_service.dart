// data/datasources/connectivity_service.dart
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';


class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  late StreamController<bool> _connectionStatusController;

  ConnectivityService() {
    _connectionStatusController = StreamController<bool>.broadcast();
    _initialize();
  }

  void _initialize() {
    // Listen for changes in connectivity
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> result) async {
      bool hasConnection = false;

      // Check if any of the results indicate an internet connection
      for (var connectivityResult in result) {
        if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
          hasConnection = true;
          break;
        }
      }

      // Notify listeners of the connection status
      _connectionStatusController.add(hasConnection);
    });
  }

  // Expose the connection status stream
  Stream<bool> get connectionStatusStream => _connectionStatusController.stream;

  // Clean up resources
  void dispose() {
    _connectionStatusController.close();
  }
}
