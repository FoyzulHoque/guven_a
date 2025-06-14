import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Fetch email from arguments
    email.value = Get.arguments?['email'] ?? '';
  }

  String getObscuredEmail() {
    final atIndex = email.indexOf('@');
    if (atIndex < 2) return email.value;
    final domain = email.value.substring(atIndex);
    return email.value.substring(0, 2) + '*' * (atIndex - 2) + domain;
  }
}
