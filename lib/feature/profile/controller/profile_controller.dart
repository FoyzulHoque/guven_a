import 'package:get/get.dart';

class ProfileController extends GetxController {
  var isOnline = true.obs;

  void toggleStatus(bool value) {
    isOnline.value = value;
  }
}
