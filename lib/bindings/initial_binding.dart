import 'package:eng_questions/datas/repositorys/local_storage_repository.dart';
import 'package:eng_questions/datas/repositorys/service_repository.dart';
import 'package:get/get.dart';

class InitialBindigs extends Bindings {
  @override
  void dependencies() {
    Get.create(
        () => LocalStorageRepository()); //kalıcı olarak regiser edildiler!!
    Get.create(() => ServiceRepository());
  }
}
