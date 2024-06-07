import 'package:flutter/material.dart';
import 'package:flutter_uvc_camera/flutter_uvc_camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraTest extends StatefulWidget {
  const CameraTest({super.key});

  @override
  State<CameraTest> createState() => _CameraTestState();
}

class _CameraTestState extends State<CameraTest> {
  int selectIndex = 0;
  List<String> images = ['', '', '', '', '', '', ''];
  String errText = '';
  UVCCameraController? cameraController;
  @override
  void initState() {
    super.initState();
    cameraController = UVCCameraController();
    cameraController?.msgCallback = (state) {
      showCustomToast(state);
    };
  }

  void showCustomToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  String videoPath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('USB Camera Debug Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(errText),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  child: const Text('close'),
                  onPressed: () {
                    cameraController?.closeCamera();
                  },
                ),
                TextButton(
                  child: const Text('open'),
                  onPressed: () async {
                    await Permission.camera.status;
                    await cameraController?.initializeCamera();
                    await cameraController?.openUVCCamera();
                  },
                ),
              ],
            ),
            if (cameraController != null)
              SizedBox(
                  child: UVCCameraView(
                      cameraController: cameraController!,
                      params: const UVCCameraViewParamsEntity(frameFormat: 0),
                      width: 300,
                      height: 300)),
            const SizedBox(height: 100)
          ],
        ),
      ),
    );
  }
}
