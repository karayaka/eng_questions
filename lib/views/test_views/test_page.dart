import 'package:eng_questions/core/component_models/test_list_card_model.dart';
import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/core/components/custom_flexible_space_components.dart';
import 'package:eng_questions/core/components/test_list_card_component.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/datas/controllers/test_controller.dart';
import 'package:eng_questions/datas/models/service_models/test_model.dart';
import 'package:eng_questions/routings/route_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class TestPage extends StatelessWidget {
  var controller = Get.find<TestController>();
  TestPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Get.offAllNamed(RouteConst.home);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Testler"),
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
              return _buildListView();
            }
          }),
        ));
  }

  Widget _buildListView() {
    return NotificationListener<ScrollEndNotification>(
      onNotification: (t) {
        if (t.metrics.pixels > 0 && t.metrics.atEdge) {
          if (!controller.nextPageLoding) {
            controller.getTestNextPage();
          }
        }
        return false;
      },
      child: Column(
        children: [
          Expanded(child: _buildListItems()),
          GetBuilder<TestController>(
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

  Widget _buildListItems() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: RefreshIndicator(
        onRefresh: () async {
          return await controller.getTest();
        },
        child: ListView.separated(
          separatorBuilder: (_, i) => const SizedBox(
            height: 8,
          ),
          itemCount: controller.tests.length,
          itemBuilder: (_, i) {
            var test = controller.tests[i];
            if (test.card == null) {
              controller.getTestScores(test);
            }
            return Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: _buildActions(test),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (i % 2 == 0)
                      ? Colors.purple.shade50
                      : Colors.grey.shade200,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 12,
                      child: ListTile(
                        title: Text(test.testName ?? ""),
                        onTap: () {
                          _showStartMesage(test, test.card!.lastQuestionNumber);
                        },
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildListText(test.testDesc),
                            Text(test.topicName ?? ""),
                            GetBuilder<TestController>(
                                id: "item${test.id}",
                                builder: (cntrl) {
                                  return TestListCardComponent(
                                    model: test.card,
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Icon(Icons.arrow_forward_ios_outlined),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Text _buildListText(String? desc) {
    if (desc == null) {
      return const Text("");
    }
    if (desc.length > 50) {
      return Text(desc.substring(0, 50) + "...");
    } else {
      return Text(desc);
    }
  }

  _showStartMesage(TestModel model, int lastNumber) {
    var val = false;
    if ((model.testStartDesc ?? "").isNotEmpty) {
      controller.showConfirmeDialog(() {
        Get.back();
        _toRoute(model, lastNumber);
      }, title: "Dikkat", message: model.testStartDesc ?? "");
    } else {
      _toRoute(model, lastNumber);
    }
  }

  _toRoute(TestModel model, int lastNumber) {
    if (model.adsStatus != 0) {
      controller.showIterstitialAd();
    }
    Get.toNamed(RouteConst.questionDetail, arguments: {
      "adStatus": model.adsStatus,
      "testID": model.id,
      "lastNumber": lastNumber
    })?.then((value) {
      controller.getTestScores(model);
    });
  }

  List<SlidableAction> _buildActions(TestModel test) {
    return [
      SlidableAction(
        onPressed: (context) {
          controller.restTest(test).then((value) {
            controller.getTestScores(test);
          });
        },
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        icon: Icons.delete,
        label: 'Baştan Başla',
      ),
    ];
  }
}
