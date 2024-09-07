import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovator_practicle/utils/appStrings.dart';
import 'package:knovator_practicle/utils/commonWidget.dart';

import '../controller/splashController.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashController splashController = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CommonWidget().centerText(AppString().splashScreen),
      ),
    );
  }
}
