import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:appinsights/appinsights.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // save reference to plugin instance
  final _appinsightsPlugin = Appinsights();

  // provide required arguments
  void initAppinsights() async {
    String partnerId = "SecretID";
    String partnerKey = "SecretKey";
    await _appinsightsPlugin.initialize(partnerId, partnerKey);
  }


  @override
  void initState() {
    super.initState();
    initAppinsights();
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Appinsights Plugin Example",
      home: HomeScreen(appinsights: _appinsightsPlugin)
    );
  }
}

class HomeScreen extends StatelessWidget {
  final Appinsights appinsights;

  const HomeScreen({super.key, required this.appinsights});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Plugin Example')),
      body: Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton(
          onPressed: () async {
            String userId = "Flattearther1";
            await appinsights.setUserId(userId);
          },
          child: const Text('Set UserId'),
        ),
        const SizedBox(height: 16), // spacing
        ElevatedButton(
          onPressed: () async {
            final state = await appinsights.getState() ?? "unknown";
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('SDK State'),
                  content: Text(state),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Get State'),
        ),
        const SizedBox(height: 16), // spacing
        ElevatedButton(
          onPressed: () async {
            await appinsights.sendData();
            print('Collect button pressed');
          },
          child: const Text('Collect Data'),
        ),
        const SizedBox(height: 16), // spacing
        ElevatedButton(
          onPressed: () async {
            await appinsights.openUsageAccessSettings();
            print('Open Settings button pressed');
          },
          child: const Text('Open Settings'),
        ),
      ],
    ),
    ),
    );
  }
}
