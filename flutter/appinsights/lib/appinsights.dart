
import 'appinsights_platform_interface.dart';

class Appinsights {
  Future<String?> getState() {
    return AppinsightsPlatform.instance.getState();
  }

  Future<void> initialize(String partnerId, String partnerKey) {
    return AppinsightsPlatform.instance.initialize(partnerId, partnerKey);
  }

  Future<void> setUserId(String userId) {
    return AppinsightsPlatform.instance.setUserId(userId);
  }

  Future<void> sendData() {
    return AppinsightsPlatform.instance.sendData();
  }

  Future<void> openUsageAccessSettings() {
    return AppinsightsPlatform.instance.openUsageAccessSettings();
  }
}
