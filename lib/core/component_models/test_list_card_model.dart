class TestListCardModel {
  int id;
  int questionCount;
  int correctAnswerCount;
  int wrongAnswerCount;
  int emtyAnverCount;
  int lastQuestionNumber;
  bool onloaded;

  TestListCardModel({
    required this.id,
    required this.questionCount,
    required this.correctAnswerCount,
    required this.wrongAnswerCount,
    required this.emtyAnverCount,
    this.lastQuestionNumber = 0,
    this.onloaded = false,
  });
}
