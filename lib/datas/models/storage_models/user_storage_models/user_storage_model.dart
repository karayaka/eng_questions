import 'package:eng_questions/datas/local_storages/storage_const.dart';
import 'package:hive_flutter/adapters.dart';

part 'user_storage_model.g.dart';
@HiveType(typeId: StorageConst.user_storage_model_key)
class UserStorageModel extends HiveObject {



  @HiveField(0)
  String? NameAndSurname;


  UserStorageModel(
  {
    this.NameAndSurname
  });


}