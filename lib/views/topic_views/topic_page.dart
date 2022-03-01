import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/core/components/custom_flexible_space_components.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/controllers/topic_controller.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopicPage extends StatelessWidget {
  var controller = Get.find<TopicController>();
  TopicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Konular"),
        flexibleSpace: const CustomFlexibleSpaceComponent(),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isAdLoaded.value) {
          return SizedBox(
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
        if (controller.pageLoding.value) {
          return CustomCircularProgress();
        } else {
          return _buildListScrean();
        }
      }),
    );
  }

  Widget _buildListScrean() {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (t) {
        if (t.metrics.pixels > 0 && t.metrics.atEdge) {
          if (!controller.nextPageLoding) {
            controller.getTopicsNextPage();
          }
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(flex: 9, child: _buildListView()),
          GetBuilder<TopicController>(
              id: "loding",
              builder: (contro) {
                if (controller.nextPageLoding) {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CustomCircularProgress(),
                  );
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  Padding _buildListView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: controller.topics.length,
        separatorBuilder: (_, i) => const SizedBox(
          height: 8,
        ),
        itemBuilder: (_, i) {
          var topic = controller.topics[i];
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color:
                  (i % 2 == 0) ? Colors.purple.shade50 : Colors.grey.shade200,
            ),
            child: ListTile(
              title: Text(topic.topicName ?? ""),
              subtitle: Text(topic.topicDesc ?? ""),
              trailing: const Icon(
                Icons.arrow_forward_ios_outlined,
                color: Colors.black,
              ),
              onTap: () {
                Get.offNamed(RouteConst.tests, arguments: topic.id);
              },
            ),
          );
        },
      ),
    );
  }
}
