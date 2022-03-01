class QuestionStepperComponentModel {
  int questionCount;
  int questionNumber;
  int wrongAnsverCount;
  int correctAnsverCount;
  int passAnsverQuestion;

  QuestionStepperComponentModel({
    this.correctAnsverCount = 0,
    this.passAnsverQuestion = 0,
    this.questionCount = 0,
    this.questionNumber = 0,
    this.wrongAnsverCount = 0,
  });
}
