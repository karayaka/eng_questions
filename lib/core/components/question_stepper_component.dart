import 'package:eng_questions/core/component_models/question_stepper_component_model.dart';
import 'package:flutter/material.dart';

class QuestionStepperComponent extends StatelessWidget {
  late QuestionStepperComponentModel? model;

  QuestionStepperComponent({this.model, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var progres = (model!.correctAnsverCount +
            model!.wrongAnsverCount +
            model!.passAnsverQuestion) /
        model!.questionCount;
    return Column(
      children: [
        Text(
          "${model!.questionNumber}/${model!.questionCount}",
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Chip(
              label: Text("Soru: ${model!.questionCount}"),
              backgroundColor: Colors.blueGrey,
            ),
            Chip(
              label: Text("Doğru: ${model!.correctAnsverCount}"),
              backgroundColor: Colors.greenAccent,
            ),
            Chip(
              label: Text("Boş: ${model!.passAnsverQuestion}"),
              backgroundColor: Colors.orangeAccent,
            ),
            Chip(
              label: Text("Yanlış: ${model!.wrongAnsverCount}"),
              backgroundColor: Colors.red,
            ),
          ]),
        ),
        Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: LinearProgressIndicator(
              minHeight: 7,
              value: progres,
            ))
      ],
    );
  }
}
