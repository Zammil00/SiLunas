import 'package:get/get.dart';

class EditProfileController extends GetxController {
  var bottomIndex = 2.obs;

  void setBottomIndex(int index) {
    bottomIndex.value = index;
  }
}
