import 'package:chatgpt/api/chatgpt.dart';
import 'package:chatgpt/models/key_model.dart';
import 'package:chatgpt/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/local_natification.dart';

class HomepageController extends GetxController {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingcontroller = TextEditingController();
  TextEditingController keyEditingcontroller = TextEditingController();
  RxBool isAtButton = false.obs;
  List messages = [].obs;
  RxBool loading = false.obs;
  KeyModel model = KeyModel();
  LocalNotifier localNotifier = LocalNotifier();

  HomepageController();

  _initData() async {
    update(["homepage"]);
    await model.load();
    loading.value = true;
    String result = await ChatGPT(model.key.value).chat('你好');
    messages.add(Bubble(result.toString(), isLeft: false));
    loading.value = false;
    scrollController.addListener(controllerListener);
    localNotifier.init();
    keyEditingcontroller.text = model.key.value;
  }

  void controllerListener() {
    if (scrollController.offset <
        scrollController.position.maxScrollExtent - 20) {
      isAtButton.value = true;
    } else {
      isAtButton.value = false;
    }
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void jumpToLast() {
    Future.delayed(const Duration(milliseconds: 100), () {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  void clear() {
    messages.clear();
    model.key.value;
    addMessage(const Bubble('你好'));
  }

  Future<void> addMessage(Bubble message) async {
    jumpToLast();
    loading.value = true;
    model.key.value;
    messages.add(message);
    textEditingcontroller.text = '';
    String send = message.text;
    send = _continueText(message.text);
    send = _isCode(send);
    String result = await ChatGPT(model.key.value).chat(send);
    messages.add(Bubble(result.toString(), isLeft: false));
    localNotifier.show('收到新消息');
    jumpToLast();
    loading.value = false;
  }

  String _isCode(String text) {
    String send = '';
    if (text.contains('代码')) {
      send = '$text,以markdown返回';
    }
    if (send.isEmpty) {
      return text;
    }
    return send;
  }

  String _continueText(String text) {
    String send = '';
    if (text.length > 3) {
      if (text.substring(text.length - 2, text.length) == '继续') {
        send = messages[messages.length - 2].text + ',继续';
      }
      if (send.isEmpty) {
        return text;
      }
      return send;
    }
    return text;
  }
}
