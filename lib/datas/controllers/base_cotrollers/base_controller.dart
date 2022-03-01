import 'package:eng_questions/enums/result_status.dart';
import 'package:eng_questions/enums/screan_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseController extends GetxController {
  ScreanState state = ScreanState.loding;

  int pageCount = 0;
  int pageSize = 0;

  showSeviceAlert(ResultStatus type, String message) {
    switch (type) {
      case ResultStatus.succes:
        if (message.isNotEmpty) {
          succesMessage(message);
        }
        break;
      case ResultStatus.warning:
        warningMessage(message);
        break;
      case ResultStatus.danger:
        errorMessage(message);
        break;
      case ResultStatus.unauthorized: //buraya login route yapılabilir
        errorMessage("Servis Bağlatısı Yapılamadı");
        break;
    }
  }

  showConfirmeDialog(void Function()? onConfirme,
      {String title = "", String message = "", String confirmeText = "Tamam"}) {
    Get.defaultDialog(
        title: title,
        content: Text(message),
        onConfirm: onConfirme,
        textCancel: "İptal",
        textConfirm: confirmeText,
        confirmTextColor: Colors.white);
  }

  succesMessage(String message) {
    Get.snackbar(
      "Başarılı",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
    );
  }

  errorMessage(String message) {
    Get.snackbar(
      "Hata",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.orange.shade600,
    );
  }

  warningMessage(String message) {
    Get.snackbar(
      "Uyarı",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }

  I? prepareServiceModel<I>(dynamic model) {
    pageCount = model.pageCount;
    pageSize = model.pageSize; //model ve data test edilecek!!
    if (model.message != "null") {
      showSeviceAlert(model.type, model.message);
    }
    if (model.data != null) {
      return model.data;
    }
  }
}
