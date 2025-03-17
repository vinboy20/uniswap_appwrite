import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uniswap/core/utils/helpers/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  /// Getter to access the current connection status
  ConnectivityResult get connectionStatus => _connectionStatus.value;

  /// Initialize the network manager and set up a stream to continually check the connection status
  @override
  void onInit() {
    super.onInit();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  /// Initialize connectivity and set the initial connection status
  Future<void> _initConnectivity() async {
    try {
      final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } on PlatformException catch (e) {
      print("Error checking connectivity: $e");
      _connectionStatus.value = ConnectivityResult.none;
    }
  }

  /// Update connection status based on changes in connectivity and show a relevant popup for no internet connection
  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // Check if any of the results indicate a connection
    if (results.contains(ConnectivityResult.mobile) || results.contains(ConnectivityResult.wifi)) {
      _connectionStatus.value = ConnectivityResult.mobile; // or ConnectivityResult.wifi
      TLoaders.customToast(message: 'Internet connection restored');
    } else {
      _connectionStatus.value = ConnectivityResult.none;
      TLoaders.customToast(message: 'No internet connection');
    }
  }

  /// Check the internet connection status
  Future<bool> isConnected() async {
    try {
      final List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      return result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi);
    } on PlatformException catch (e) {
      print("Error checking connectivity: $e");
      return false;
    }
  }

  /// Dispose or close the active connectivity stream
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}