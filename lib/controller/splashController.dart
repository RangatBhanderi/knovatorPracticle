import 'dart:async';

import 'package:get/get.dart';
import 'package:knovator_practicle/view/postViewScreen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToMain();
  }

  void navigateToMain() {
    Timer(const Duration(seconds: 3), () => Get.off(const PostViewScreen()));
  }
}
