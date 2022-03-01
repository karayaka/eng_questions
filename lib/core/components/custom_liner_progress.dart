import 'package:flutter/material.dart';
class CustomLinerProgress extends StatelessWidget {
  const CustomLinerProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: LinearProgressIndicator(),
    );
  }
}
