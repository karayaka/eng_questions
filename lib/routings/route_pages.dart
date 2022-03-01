import 'package:eng_questions/bindings/home_binding.dart';
import 'package:eng_questions/bindings/level_binding.dart';
import 'package:eng_questions/bindings/login_binding.dart';
import 'package:eng_questions/bindings/question_binding.dart';
import 'package:eng_questions/bindings/splash_binding.dart';
import 'package:eng_questions/bindings/test_binding.dart';
import 'package:eng_questions/bindings/topic_binding.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:eng_questions/views/home_view/home.dart';
import 'package:eng_questions/views/level_views/level_page.dart';
import 'package:eng_questions/views/question_views/question_page.dart';
import 'package:eng_questions/views/security_views/login.dart';
import 'package:eng_questions/views/security_views/splash.dart';
import 'package:eng_questions/views/test_views/test_page.dart';
import 'package:eng_questions/views/topic_views/topic_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class RoutePages {
  static Transition _transition = Transition.rightToLeft;
  static final pages = [
    GetPage(
      name: RouteConst.home,
      page: () => Home(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteConst.splash,
      page: () => Splash(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: RouteConst.login,
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: RouteConst.levels,
      page: () => LevelPage(),
      //transition: _transition,
      binding: LevelBinding(),
    ),
    GetPage(
      name: RouteConst.tests,
      page: () => TestPage(),
      //transition: _transition,
      binding: TestBinding(),
    ),
    GetPage(
      name: RouteConst.topics,
      page: () => TopicPage(),
      //transition: _transition,
      binding: TopicBinding(),
    ),
    GetPage(
      name: RouteConst.questionDetail,
      page: () => QuestionPage(),
      //transition: _transition,
      binding: QuestionBinding(),
    ),
  ];
}
