import 'package:chatgpt/widgets/bubble.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return HomepageViewGetX();
  }
}

class HomepageViewGetX extends GetView<HomepageController> {
  HomepageViewGetX({super.key});
  final HomepageController homepageController = Get.put(HomepageController());

  Widget _buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('聊天'),
        actions: [
          GestureDetector(
            onTap: () {
              homepageController.clear();
              homepageController.isAtButton.value = false;
            },
            child: const Icon(Icons.refresh),
          ),
          const Padding(padding: EdgeInsets.only(right: 5)),
          GestureDetector(
            onTap: () {
              _showDialog();
            },
            child: const Icon(Icons.key),
          ),
          const SizedBox(width: 10)
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Obx(() => homepageController.loading.value
                ? const LinearProgressIndicator()
                : const SizedBox())),
      ),
      body: Stack(
        children: [
          Container(color: const Color.fromRGBO(52, 53, 65, 1)),
          Column(
            children: [
              Expanded(
                child: Obx(() => ListView.builder(
                      controller: homepageController.scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: homepageController.messages.length,
                      itemBuilder: (_, index) =>
                          homepageController.messages[index],
                    )),
              ),
              textField(context)
            ],
          ),
          Obx(() => jumpToLast())
        ],
      ),
    );
  }

  Widget textField(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        width: MediaQuery.of(context).size.width - 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(64, 65, 79, 1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextField(
          cursorColor: Colors.white,
          scrollPadding: const EdgeInsets.all(0),
          style: const TextStyle(color: Colors.white, fontSize: 25),
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                Icons.send,
                size: 30,
              ),
              color: Colors.white,
              onPressed: () {
                homepageController.addMessage(
                    Bubble(homepageController.textEditingcontroller.text));
              },
            ),
          ),
          controller: homepageController.textEditingcontroller,
          onSubmitted: (input) {
            homepageController.addMessage(Bubble(input));
          },
        ));
  }

  Widget jumpToLast() {
    return homepageController.isAtButton.value
        ? Positioned(
            bottom: 70,
            right: 10,
            child: GestureDetector(
              onTap: () {
                homepageController.jumpToLast();
              },
              child: ClipOval(
                child: Container(
                  color: Colors.grey,
                  child: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          )
        : const SizedBox();
  }

  void _showDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color.fromRGBO(52, 53, 65, 1),
        title: const Text('请输入Key', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: homepageController.keyEditingcontroller,
          style: const TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('取消'),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: const Text('确定'),
            onPressed: () {
              homepageController.model.key.value =
                  homepageController.keyEditingcontroller.text;
              homepageController.model
                  .save(homepageController.keyEditingcontroller.text);
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomepageController>(
      init: homepageController,
      id: "homepage",
      builder: (_) {
        return _buildView(context);
      },
    );
  }
}
