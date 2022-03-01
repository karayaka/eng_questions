import 'package:eng_questions/datas/local_storages/base_db_manager.dart';
import 'package:eng_questions/datas/local_storages/storage_const.dart';
import 'package:eng_questions/datas/models/storage_models/user_storage_models/user_storage_model.dart';
import 'package:hive_flutter/adapters.dart';

class UserDbManager extends BaseDbManager<UserStorageModel>{
  UserDbManager() : super(StorageConst.user_storage_model_name);

  @override
  void registerAdapters() {
    if(!Hive.isAdapterRegistered(StorageConst.user_storage_model_key)){
      Hive.registerAdapter(UserStorageModelAdapter());
    }
  }

}