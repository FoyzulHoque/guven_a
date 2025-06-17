import 'package:get/get.dart';

class NotificationController extends GetxController {
  var isSound = true.obs;
  var isOne = true.obs;
  var isSeverel = true.obs;
  var isNotification = true.obs;

  void toggleSound(bool value) {
    isSound.value = value;
  }

  void toggleOneNotification(bool value) {
    isOne.value = value;
  }

  void severelNotification(bool value) {
    isSeverel.value = value;
  }

  void toggleNotification(bool value) {
    isNotification.value = value;
  }
}
