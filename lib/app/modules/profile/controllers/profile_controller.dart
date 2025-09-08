import 'package:get/get.dart';

class ProfileController extends GetxController {
  var bottomIndex = 2.obs;

  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }
}
