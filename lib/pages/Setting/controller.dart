import 'package:chatgpt/common/models/key_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  RxKeyModel model = RxKeyModel();
  TextEditingController keyController = TextEditingController();

  _initData() async {
    update(["setting"]);
    await model.load();
    keyController.text = model.key.value;
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void setKey(String text) {
    model.key.value = text;
    model.save();
  }
}
