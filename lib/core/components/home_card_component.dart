import 'package:flutter/material.dart';
class HomeCardComponent extends StatelessWidget {
  String? title;
  String? count;
  Color? color;
  void Function()? onTab;
  HomeCardComponent({
    Key? key,
    this.title,
    this.count,
    this.onTab,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15),),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 3,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(count??"",style: const TextStyle(fontSize: 34,color: Colors.white, fontWeight: FontWeight.bold),),
              Text(title??"",style: const TextStyle(fontSize: 24,color: Colors.white,),)
            ],
          ),
        ),
      ),
    );
  }
}
