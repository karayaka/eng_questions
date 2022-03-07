import 'package:eng_questions/datas/models/base_models/base_service_model.dart';

class TestModel extends BaseServiceModel {
  int? id;
  String? topicName;
  String? testName;
  String? testDesc;
  int? questionCount;
  String? testStartDesc;
  bool? showTestStartDesc;
  int? testStatus;
  int? adsStatus;
  //test scores buraya ekelenecek ve o scorun durumuna göre kotrol yapılacak

  TestModel(
      {this.id,
      this.topicName,
      this.testName,
      this.testDesc,
      this.questionCount,
      this.testStartDesc,
      this.testStatus,
      this.showTestStartDesc,
      this.adsStatus});

  @override
  fromMap(Map<String, dynamic> map) => TestModel(
        id: map["id"],
        questionCount: map["questionCount"],
        showTestStartDesc: map["showTestStartDesc"],
        testDesc: map["testDesc"],
        testName: map["testName"],
        testStartDesc: map["testStartDesc"],
        topicName: map["topicName"],
        adsStatus: map["adsStatus"],
        testStatus: map["testStatus"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "questionCount": questionCount,
        "showTestStartDesc": showTestStartDesc,
        "testDesc": testDesc,
        "testName": testName,
        "testStartDesc": testStartDesc,
        "topicName": topicName,
        "adsStatus": adsStatus,
        "testStatus": testStatus,
      };
}
