import 'package:eng_questions/datas/models/base_models/base_service_model.dart';

class LevelModel extends BaseServiceModel {
  int? id;
  String? levelName;
  String? levelDesc;
  int? topicCount;

  LevelModel({this.id, this.levelName, this.levelDesc, this.topicCount});

  @override
  fromMap(Map<String, dynamic> map) => LevelModel(
        id: map["id"],
        topicCount: map["topicCount"],
        levelDesc: map["levelDesc"],
        levelName: map["levelName"],
      );

  @override
  Map<String, dynamic> toMap() => {
        "id": id,
        "levelName": levelName,
        "topicCount": topicCount,
        "levelDesc": levelDesc,
      };
}
