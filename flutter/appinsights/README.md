# Appinsights

A Flutter plugin for Appinsights.

## Getting Started

To integrate the Appinsights Flutter SDK into your Flutter project, follow these steps:

Open your project's pubspec.yaml file.
Add the Appinsights SDK as a dependency under the dependencies section. 

```
dependencies:
appinsights:
    git:
        url: https://github.com/apptopia/appinsights
        path: "flutter/appinsights"
```
Save the pubspec.yaml  

In your IDE run command: 
    `flutter pub get`


## Init of SDK
Call `initialize()` on early stage of application lifecycle 
```
import 'package:appinsights/appinsights.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // required to call before initialize

  final appinsight = Appinsights();
  String partnerId = "";
  String partnerKey = "";

  await appinsight.initialize(partnerId, partnerKey);
  var state = await appinsight.getState();
  // print(state);
  runApp(const MyApp());
}
```
When you obtain unique user identifier please share the value with SDK by calling `setUserId()`
```
String userId = "Flattearther1@example.com";
await appinsights.setUserId(userId);
```

## Platform requirement
Please update your build.gradle, remove exact `ndkVersion` and update `minSdk` to 24
```    
android {
//    ndkVersion = flutter.ndkVersion 
... 
    defaultConfig {
        ...
        minSdk = 24
        
    }
}
```