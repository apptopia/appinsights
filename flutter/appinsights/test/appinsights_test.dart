import 'package:flutter_test/flutter_test.dart';
import 'package:appinsights/appinsights_platform_interface.dart';
import 'package:appinsights/appinsights_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAppinsightsPlatform
    with MockPlatformInterfaceMixin
    implements AppinsightsPlatform {


  @override
  Future<String?> getState() {
    // TODO: implement getState
    throw UnimplementedError();
  }

  @override
  Future<void> initialize(String partnerId, String partnerKey) {
    // TODO: implement initialize
    throw UnimplementedError();
  }

  @override
  Future<void> openUsageAccessSettings() {
    // TODO: implement openUsageAccessSettings
    throw UnimplementedError();
  }

  @override
  Future<void> setUserId(String userId) {
    // TODO: implement setUserId
    throw UnimplementedError();
  }

  @override
  Future<void> sendData() {
    // TODO: implement sendData
    throw UnimplementedError();
  }
}

void main() {
  final AppinsightsPlatform initialPlatform = AppinsightsPlatform.instance;

  test('$MethodChannelAppinsights is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAppinsights>());
  });
}
