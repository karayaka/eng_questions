import 'package:eng_questions/bindings/initial_binding.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:eng_questions/routings/route_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitialBindigs(),
      //color: Colors.purple,
      title: 'İngilizce Sorular',
      //theme: PurpleThemeData,
      getPages: RoutePages.pages,
      initialRoute: RouteConst.splash,
    );
  }
}
