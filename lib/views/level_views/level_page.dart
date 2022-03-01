import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/core/components/custom_flexible_space_components.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/controllers/level_controller.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LevelPage extends StatelessWidget {
  var controller = Get.find<LevelController>();
  LevelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Seviyeler"),
          flexibleSpace: const CustomFlexibleSpaceComponent(),
        ),
        bottomNavigationBar: Obx(() {
          if (controller.isAdLoaded.value) {
            print(controller.isAdLoaded.value);
            return Container(
              height: controller.bannerAd.size.height.toDouble(),
              width: controller.bannerAd.size.width.toDouble(),
              child: AdWidget(
                ad: controller.bannerAd,
              ),
            );
          } else {
            return const SizedBox(
              height: 8,
            );
          }
        }),
        body: Obx(() {
          if (controller.listLoading.value) {
            return CustomCircularProgress();
          } else {
            return _buildList();
          }
        }));
  }

  Widget _buildList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        separatorBuilder: (_, i) => const SizedBox(
          height: 8,
        ),
        itemCount: controller.levels.length,
        itemBuilder: (context, i) {
          var level = controller.levels[i];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  (i % 2 == 0) ? Colors.purple.shade50 : Colors.grey.shade200,
            ),
            child: ListTile(
              title: Text(level.levelName ?? ""),
              subtitle: Text(level.levelDesc ?? ""),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Get.offNamed(RouteConst.topics, arguments: level.id);
              },
            ),
          );
        },
      ),
    );
  }
}
