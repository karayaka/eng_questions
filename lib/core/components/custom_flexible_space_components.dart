import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomFlexibleSpaceComponent extends StatelessWidget {
  const CustomFlexibleSpaceComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Get.theme.primaryColorDark,
            Colors.deepOrange,
          ])),
    );
  }
}
