import 'package:camera/camera.dart' as cam;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guven_a/core/style/global_text_style.dart';
import 'package:guven_a/feature/send_photo/screen/send_photo.dart';

// Adjust path

class CustomCameraScreen extends StatefulWidget {
  final String postId; // This is correctly declared

  // Add the constructor here to accept the postId
  const CustomCameraScreen({Key? key, required this.postId}) : super(key: key);

  @override
  _CustomCameraScreenState createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  late cam.CameraController _cameraController;
  late List<cam.CameraDescription> _cameras;
  bool isCameraInitialized = false;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await cam.availableCameras();
    if (cameras.isNotEmpty) {
      _cameras = cameras;
      _cameraController = cam.CameraController(
        _cameras[0],
        cam.ResolutionPreset.high,
      );
      await _cameraController.initialize();
      setState(() {
        isCameraInitialized = true;
      });
    } else {
      print("No cameras available.");
      // Handle case where no cameras are available, e.g., show an error message
      Get.snackbar('Error', 'No cameras found on this device.');
    }
  }

  Future<void> _captureImage() async {
    if (!_cameraController.value.isInitialized) {
      Get.snackbar('Error', 'Camera not initialized. Please try again.');
      return;
    }
    try {
      final image = await _cameraController.takePicture();
      setState(() {
        imagePath = image.path;
      });
      print(
        "Captured image for postId: ${widget.postId} at: $imagePath",
      ); // Access postId here!
      Get.to(
        () => ImagePreviewScreen(imagePath: image.path, postId: widget.postId),
      ); // Pass postId to next screen
    } catch (e) {
      print("Error capturing image: $e");
      Get.snackbar('Error', 'Failed to capture image: $e');
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: isCameraInitialized
            ? Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          "assets/images/logo2.png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20),
                        Text(
                          "Create request", // Consider changing this to "Take Photo" or "Capture Evidence"
                          style: globalTextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Image.asset(
                            "assets/images/remove.png",
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: cam.CameraPreview(_cameraController),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: GestureDetector(
                        onTap: _captureImage,
                        child: Image.asset(
                          "assets/images/capture.png",
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()), // Added const
      ),
    );
  }
}
