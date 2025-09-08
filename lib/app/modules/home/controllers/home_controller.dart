import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedMenu = 1.obs;
  var bottomIndex = 0.obs;

  void setMenu(int index) {
    selectedMenu.value = index;
  }

  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }
}
