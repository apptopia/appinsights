import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'appinsights_method_channel.dart';

abstract class AppinsightsPlatform extends PlatformInterface {
  /// Constructs a AppinsightsPlatform.
  AppinsightsPlatform() : super(token: _token);

  static final Object _token = Object();

  static AppinsightsPlatform _instance = MethodChannelAppinsights();

  /// The default instance of [AppinsightsPlatform] to use.
  ///
  /// Defaults to [MethodChannelAppinsights].
  static AppinsightsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AppinsightsPlatform] when
  /// they register themselves.
  static set instance(AppinsightsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getState() {
    throw UnimplementedError('getState() has not been implemented.');
  }

  Future<void> initialize(String partnerId, String partnerKey) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<void> sendData() {
    throw UnimplementedError('collect() has not been implemented.');
  }


  Future<void> setUserId(String userId) {
    throw UnimplementedError('setUserId() has not been implemented.');
  }

  Future<void> openUsageAccessSettings() async {
    throw UnimplementedError('openUsageAccessSettings() has not been implemented.');
  }
}
