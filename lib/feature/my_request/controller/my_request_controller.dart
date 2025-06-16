import 'package:get/get.dart';

class MyRequestController extends GetxController {
  var currentTabIndex = 0.obs; // Rx variable to hold the current tab index

  // Method to change the selected tab index
  void changeTab(int index) {
    currentTabIndex.value = index;
  }
}
