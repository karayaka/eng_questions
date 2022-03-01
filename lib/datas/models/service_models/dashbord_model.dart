import 'package:eng_questions/datas/models/base_models/base_service_model.dart';

class DashbordModel extends BaseServiceModel{
  int id=0;
  int levelCount=0;
  int topicCount=0;
  int testCount=0;
  int quetionCount=0;


  DashbordModel({this.id=0,
    this.levelCount=0,
    this.topicCount=0,
    this.testCount=0,
    this.quetionCount=0
  });

  @override
  fromMap(Map<String, dynamic> map) =>DashbordModel(
    id: map["id"],
    levelCount: map["levelCount"],
    quetionCount: map["quetionCount"],
    testCount: map["testCount"],
    topicCount: map["topicCount"],
  );

  @override
  Map<String, dynamic> toMap()  => {
    "id":id,
    "levelCount":levelCount,
    "quetionCount":quetionCount,
    "testCount":testCount,
    "topicCount":topicCount,
  };

}