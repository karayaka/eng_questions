import 'package:eng_questions/core/component_models/test_list_card_model.dart';
import 'package:flutter/material.dart';
import 'custom_liner_progress.dart';
import 'liner_determinate_progress.dart';

class TestListCardComponent extends StatelessWidget {
  TestListCardModel? model;
  void Function()? onTab;
  TestListCardComponent({required this.model, this.onTab, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (model != null) ? buildScores() : buildProgress();
  }

  Widget buildProgress() {
    return Column(
      children: const [
        SizedBox(
          height: 3,
        ),
        CustomLinerProgress()
      ],
    );
  }

  Widget buildScores() {
    var progress = ((model!.emtyAnverCount +
            model!.wrongAnswerCount +
            model!.correctAnswerCount) /
        model!.questionCount);

    return Column(
      children: [
        const SizedBox(
          height: 3,
        ),
        LinerDeterminateProgress(
          progress: progress,
        ),
        const SizedBox(
          height: 3,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Chip(
            label: Text("Soru ${model!.questionCount}"),
            backgroundColor: Colors.blueGrey,
          ),
          Chip(
            label: Text("Doğru ${model!.correctAnswerCount}"),
            backgroundColor: Colors.greenAccent,
          ),
          Chip(
            label: Text("Yanlış ${model!.wrongAnswerCount}"),
            backgroundColor: Colors.red,
          ),
          Chip(
            label: Text("Boş ${model!.emtyAnverCount}"),
            backgroundColor: Colors.orangeAccent,
          ),
        ])
      ],
    );
  }
}
