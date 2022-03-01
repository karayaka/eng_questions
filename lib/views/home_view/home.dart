import 'package:eng_questions/core/components/custom_bar_chart.dart';
import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/core/components/custom_flexible_space_components.dart';
import 'package:eng_questions/core/components/home_card_component.dart';
import 'package:eng_questions/core/components/welcome_message_component.dart';
import 'package:eng_questions/datas/controllers/home_controller.dart';
import 'package:eng_questions/datas/models/service_models/dashbord_model.dart';
import 'package:eng_questions/datas/services/notification_service.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  var controller = Get.find<HomeController>();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Ana Sayfa"),
          centerTitle: true,
          flexibleSpace: const CustomFlexibleSpaceComponent(),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80),
              child: Obx(() {
                return WelcomeMessageComponent(
                  name: controller.user.value.NameAndSurname,
                );
              })),
        ),
        /*floatingActionButton: FloatingActionButton(
          onPressed: () async {
            NotificationService.showNotification(title: "Deneme", body: "Body");
          },
          child: const Icon(Icons.add),
        ),*/
        body: Container(
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10),
            children: [
              SizedBox(
                height: 300,
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const CustomCircularProgress();
                  } else {
                    return _buildCards(controller.dashbord);
                  }
                }),
              ),
              Obx(() {
                if (controller.chartsLoding.value) {
                  return const CustomCircularProgress();
                } else {
                  return Card(
                    child: Column(
                      children: [
                        const Text("Günlük Skor"),
                        SizedBox(
                            height: (Get.size.height - 500),
                            child: CustomBarChart(data: controller.series))
                      ],
                    ),
                  );
                }
              })
            ],
          ),
        ));
  }

  Widget _buildCards(DashbordModel model) {
    return GridView(
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
      ),
      children: [
        HomeCardComponent(
          color: Colors.purple,
          title: "Seviye Sayısı",
          count: "${model.levelCount}",
          onTab: () {
            Get.toNamed(RouteConst.levels);
          },
        ),
        HomeCardComponent(
          color: Colors.orange.shade900,
          title: "Konu Sayısı",
          count: "${model.topicCount}",
          onTab: () {
            Get.toNamed(RouteConst.topics);
          },
        ),
        HomeCardComponent(
          color: Colors.blue,
          title: "Test Sayısı",
          count: "${model.testCount}",
          onTab: () {
            Get.toNamed(RouteConst.tests);
          },
        ),
        HomeCardComponent(
          color: Colors.blueGrey,
          title: "Soru Sayısı",
          count: "${model.quetionCount}",
        ),
      ],
    );
  }
}
