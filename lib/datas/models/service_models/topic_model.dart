

import 'package:eng_questions/datas/models/base_models/base_service_model.dart';

class TopicModel extends BaseServiceModel{
  int? id;
  String? topicName;
  String? levelName;
  String? topicDesc;
  int? topicCount;


  TopicModel(
      {this.id, this.topicName, this.levelName, this.topicDesc, this.topicCount});

  @override
  fromMap(Map<String, dynamic> map)=>TopicModel(
    id: map["id"],
    levelName: map["levelName"],
    topicCount: map["topicCount"],
    topicDesc: map["topicDesc"],
    topicName:map["topicName"],
  );

  @override
  Map<String, dynamic> toMap() => {
    "topicCount":topicCount,
    "levelName":levelName,
    "id":id,
    "topicName":topicName,
    "topicDesc":topicDesc,
  };

}