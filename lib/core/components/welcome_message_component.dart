import 'package:flutter/material.dart';

class WelcomeMessageComponent extends StatelessWidget {
  String? name;
  WelcomeMessageComponent({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hoş Geldin",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          Text(
            name ?? "",
            style: const TextStyle(
                fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
