import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'camera.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var cameraStatus = await Permission.camera.status;
  var audioStatus =
      await Permission.microphone.status; // Assuming you need microphone access

  if (!cameraStatus.isGranted || !audioStatus.isGranted) {
    // If either permission is not granted, request them
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();

    // Check the results
    if ((statuses[Permission.camera]!.isGranted) &&
        (statuses[Permission.microphone]!.isGranted)) {
      // Both permissions granted, proceed with camera initialization

      print('Camera initialized and opened');
    } else {
      // Handle the case where permissions were not granted
      print('Permissions not granted');
      // Optionally, show a dialog or toast to inform the user
    }
  }
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('uvc设备测试')),
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CameraTest()));
            },
            child: const Text('camera test')),
      ),
    );
  }
}
