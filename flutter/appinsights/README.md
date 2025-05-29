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
// save reference to plugin instance
final _appinsightsPlugin = Appinsights();

// provide required arguments
void initAppinsights() async {
    String partnerId = "SecretID";
    String partnerKey = "SecretKey";
    await _appinsightsPlugin.initialize(partnerId, partnerKey);
}
```
When you obtain unique user identifier please share the value to SDK by calling `setUserId()`
```
String userId = "Flattearther1@example.com";
await appinsights.setUserId(userId);
```