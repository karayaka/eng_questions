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
          Container(
            decoration:BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Soru ${model!.questionCount}",style: TextStyle(color: Colors.white),),
            ),
          ),
          Container(
            decoration:BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Doğru ${model!.correctAnswerCount}",),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 3),
            decoration:BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Yanlış ${model!.wrongAnswerCount}"),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 3),
            decoration:BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text("Boş ${model!.emtyAnverCount}"),
            ),
          ),
        ])
      ],
    );
  }
}
