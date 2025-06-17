// import 'package:camera/camera.dart' as cam;
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:permission_handler/permission_handler.dart';

// class CustomCameraController extends GetxController {
//   late cam.CameraController _cameraController;
//   List<cam.CameraDescription> cameras = [];
//   RxBool isCameraInitialized = false.obs;
//   RxString imagePath = ''.obs;

//   @override
//   void onInit() async {
//     super.onInit();
//     PermissionStatus status = await Permission.camera.request();

//     if (status.isGranted) {
//       cameras = await cam.availableCameras();
//       if (cameras.isNotEmpty) {
//         _cameraController = cam.CameraController(
//           cameras[0],
//           cam.ResolutionPreset.high,
//         );
//         try {
//           await _cameraController.initialize();
//           print('Camera Initialized');
//           if (_cameraController.value.isInitialized) {
//             isCameraInitialized.value = true;
//           } else {
//             print('Camera failed to initialize');
//           }
//         } catch (e) {
//           print("Error initializing camera: $e");
//         }
//       } else {
//         print("No cameras available");
//       }
//     } else {
//       print("Camera permission denied");
//     }
//   }

//   cam.CameraController get cameraController => _cameraController;

//   Future<void> captureImage() async {
//     try {
//       final image = await _cameraController.takePicture();
//       imagePath.value = image.path;
//       print("Captured image at: ${image.path}");
//     } catch (e) {
//       print('Error capturing image: $e');
//     }
//   }

//   @override
//   void onClose() {
//     _cameraController.dispose();
//     super.onClose();
//   }
// }
