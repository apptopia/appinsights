import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'appinsights_platform_interface.dart';

/// An implementation of [AppinsightsPlatform] that uses method channels.
class MethodChannelAppinsights extends AppinsightsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('appinsights');

  @override
  Future<String?> getState() async {
    final state = await methodChannel.invokeMethod<String>('getState');
    return state;
  }

  @override
  Future<void> initialize(String partnerId, String partnerKey) async {
    return await methodChannel.invokeMethod('initialize', {
      'partnerId': partnerId,
      'partnerKey': partnerKey
    });
  }

  @override
  Future<void> sendData() async {
    return await methodChannel.invokeMethod('sendData');
  }

  @override
  Future<void> setUserId(String userId) async {
    return await methodChannel.invokeMethod('setUserId', {
      'userId': userId
    });
  }

  @override
  Future<void> openUsageAccessSettings() async {
    return await methodChannel.invokeMethod('openUsageAccessSettings');
  }
}
