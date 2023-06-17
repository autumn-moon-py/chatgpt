import 'package:chatgpt/pages/Home/controller.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Bubble extends StatelessWidget {
  const Bubble(this.text, {super.key, this.isLeft = true});

  final String text;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTapDown: (details) {
        _showMenu(
            context, details.globalPosition.dx, details.globalPosition.dy);
      },
      onLongPress: () {
        Get.to(() => fullScreen());
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        color: isLeft
            ? const Color.fromRGBO(52, 53, 65, 1)
            : const Color.fromRGBO(68, 70, 84, 1),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ),
    );
  }

  Widget fullScreen() {
    return Scaffold(
        appBar: AppBar(title: const Text('详情'), actions: [
          TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: searchCode(text)));
                Get.snackbar('提示', '复制成功', colorText: Colors.white);
              },
              child: const Text(
                '复制代码',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ))
        ]),
        body: Stack(
          children: [
            Container(color: const Color.fromRGBO(52, 53, 65, 1)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                width: double.infinity,
                child: SelectableText(
                  text,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ));
  }

  void _showMenu(BuildContext context, double x, double y) {
    final List<String> options = ['复制', '复制代码', '重发'];
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(x, y, x, 0),
      items: options
          .map((String option) => PopupMenuItem<String>(
                value: option,
                onTap: () {
                  switch (option) {
                    case '复制':
                      Clipboard.setData(ClipboardData(text: text));
                      Get.snackbar('提示', '复制成功', colorText: Colors.white);
                      break;
                    case '重发':
                      HomepageController homepageController =
                          Get.put(HomepageController());
                      homepageController.addMessage(Bubble(text));
                      break;
                    case '复制代码':
                      Clipboard.setData(ClipboardData(text: searchCode(text)));
                      Get.snackbar('提示', '复制成功', colorText: Colors.white);
                      break;
                  }
                },
                child: Text(
                  option,
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                ),
              ))
          .toList(),
    );
  }

  String searchCode(String input) {
    List<String> codeBlocks = [];
    int index = 0;
    while (index < input.length) {
      int start = input.indexOf("```", index);
      if (start == -1) {
        break;
      }
      String str = input.substring(start, start + 10);
      int twoStart = str.indexOf('\r\n');
      start += twoStart;
      int end = input.indexOf("```", start + 3);
      if (end == -1) {
        break;
      }
      codeBlocks.add(input.substring(start + 3, end).trim());
      index = end + 3;
    }
    String allCode = '';
    for (var code in codeBlocks) {
      allCode += '\r\n$code';
    }
    if (codeBlocks.isEmpty) {
      return input;
    }
    return allCode;
  }
}
