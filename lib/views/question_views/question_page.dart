import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:eng_questions/core/components/custom_circular_progress.dart';
import 'package:eng_questions/core/components/custom_flexible_space_components.dart';
import 'package:eng_questions/core/components/question_stepper_component.dart';
import 'package:eng_questions/datas/controllers/question_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPage extends StatelessWidget {
  var controller = Get.find<QuestionContoller>();
  QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _backConfirme();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Sorular"), //get routan title alınacak
            flexibleSpace: const CustomFlexibleSpaceComponent(),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(80),
                child: Obx(() {
                  if (controller.scoreLoding.value) {
                    return LinearProgressIndicator();
                  } else {
                    return QuestionStepperComponent(
                      model:
                          controller.testScore, //bu model controllerden gelecek
                    );
                  }
                })),
          ),
          body: Obx(() {
            if (controller.questionLoding.value) {
              return CustomCircularProgress();
            } else {
              return _buildQuestion();
            }
          })),
    );
  }

  Column _buildQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 6,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                controller.questionModel.questionDesc ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Doğru Seçeniğe Dokunun',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade600,
                  fontSize: 12),
            ),
          ),
        ),
        Expanded(flex: 12, child: _buildOptions())
      ],
    );
  }

  Widget _buildOptions() {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildOption("A", controller.questionModel.ansverA ?? "", i: 0),
          _buildOption("B", controller.questionModel.ansverB ?? "", i: 1),
          _buildOption("C", controller.questionModel.ansverC ?? "", i: 2),
          _buildOption("D", controller.questionModel.ansverD ?? "", i: 3),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                _checkCorreckResult(-1);
              },
              child: const Text("Atla"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOption(String option, String optionText, {int i = -2}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
          //height: 50,
          decoration: BoxDecoration(
              color: Colors.grey
                  .shade200, //(i == 1) ? Colors.green.shade300 : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16)),
          child: ListTile(
            leading: Text(
              option,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            title: Text(
              optionText,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            onTap: () {
              if (i != -2) {
                _checkCorreckResult(i);
              }
            },
          )),
    );
  }

// doğru vevap bottum sheette gösterilmeli mi
  _checkCorreckResult(int index) {
    if (index == -1) {
      _showAnswerSheet(-1);
      controller.questionAnsvered(0);
    } else {
      if ((controller.questionModel.correctAnswer ?? 0) == index) {
        _showAnswerSheet(1);
        controller.questionAnsvered(1);
      } else {
        _showAnswerSheet(0);
        controller.questionAnsvered(-1);
      }
    }
  }

  _showAnswerSheet(int ansverID) {
    Get.bottomSheet(
        Wrap(
          children: [
            Center(child: _buildBottomTitle(ansverID)),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: _buildshowedOptions(),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                controller.questionModel.answerDesc ?? "",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const Divider(
              height: 2,
              color: Colors.black,
            ),
            Center(
              child: _buildAdWidget(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),
                      child: const Text("Çıkış"),
                      onPressed: () {
                        controller.showConfirmeDialog(
                          () {
                            Get.back(result: true);
                            Get.back(result: true);
                            Get.back(result: true);
                          },
                          title: "Uyarı",
                          message: "Çıkmak İstediğnizden Emin Misiniz?",
                          confirmeText: "Evet",
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      child: const Text("Devam"),
                      onPressed: () {
                        Get.back(result: true);
                        if (controller.questionNumber >= controller.pageCount) {
                          Get.back(result: true);
                        } else {
                          controller.nextQuestion();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        isDismissible: false,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ));
  }

  Widget _buildshowedOptions() {
    int ansver = controller.questionModel.correctAnswer ?? 0;
    if (ansver == 0) {
      return _buildOption(
        "A",
        controller.questionModel.ansverA ?? "",
      );
    } else if (ansver == 1) {
      return _buildOption(
        "B",
        controller.questionModel.ansverB ?? "",
      );
    } else if (ansver == 2) {
      return _buildOption(
        "C",
        controller.questionModel.ansverC ?? "",
      );
    } else {
      return _buildOption("D", controller.questionModel.ansverD ?? "");
    }
  }

  _buildAdWidget() {
    if (controller.isAdLoaded.value) {
      print(controller.isAdLoaded.value);
      return SizedBox(
        height: controller.bannerAd.size.height.toDouble(),
        width: controller.bannerAd.size.width.toDouble(),
        child: AdWidget(
          ad: controller.bannerAd,
        ),
      );
    } else {
      return const SizedBox(
        height: 1,
      );
    }
  }

  Widget _buildBottomTitle(int ansverID) {
    if (ansverID == 1) {
      return const Text(
        "Doğru",
        style: TextStyle(
            color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold),
      );
    } else if (ansverID == 0) {
      return const Text(
        "Yanlış",
        style: TextStyle(
            color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
      );
    } else {
      return const Text(
        "Boş",
        style: TextStyle(
            color: Colors.orange, fontSize: 30, fontWeight: FontWeight.bold),
      );
    }
  }

  _backConfirme() {
    controller.showConfirmeDialog(
      () {
        Get.back(result: true);
        Get.back(result: true);
      },
      title: "Uyarı",
      message: "Çıkmak İstediğnizden Emin Misiniz?",
      confirmeText: "Evet",
    );
  }
}
