import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/datas/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splash extends StatelessWidget {
  var controller = Get.find<SplashController>();
  Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
            Get.theme.primaryColorDark,
            Colors.deepOrange,
          ])),
      child: const Center(child: CustomCircularProgress()),
    );
  }
}
