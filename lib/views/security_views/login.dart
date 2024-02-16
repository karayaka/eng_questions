import 'package:eng_questions/app_tools/form_validater.dart';
import 'package:eng_questions/datas/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  var cntrl = Get.find<LoginController>();
  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: (Get.size.height) * 0.4,
              color: Get.theme.primaryColor,
              child: const Center(
                  child: Text(
                "Sorularla İngilizce Öğren",
                style: TextStyle(color: Colors.white, fontSize: 20),
              )),
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                margin: const EdgeInsets.all(25),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Form(
                    key: cntrl.loginKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 25,
                        ), //cok değilmi
                        Text("Giriş",
                            style: TextStyle(
                                color: Colors.green[500],
                                fontWeight: FontWeight.bold)),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          validator: (val) {
                            return FormValidater.minCart(val, 4);
                          },
                          onChanged: (val) {
                            cntrl.userName = val;
                          },
                          decoration: const InputDecoration(
                            labelText: "Kullanıcı Adı Soyadı",
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blueGrey, width: 2),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                            width: double.infinity,
                            height: 40,
                            child: Obx(() {
                              if (cntrl.loading.value) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              } else {
                                return ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Get.theme.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),                                  ),
                                  child: const Text(
                                    "Başla",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    cntrl.Login();
                                  },
                                );
                              }
                            })),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
