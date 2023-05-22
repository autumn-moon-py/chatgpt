import 'package:chatgpt/common/style/app_style.dart';
import 'package:chatgpt/pages/Home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(  GetMaterialApp(
          home: const HomePage(),
          theme: AppStyle.defaultThemeData,
          debugShowCheckedModeBanner: false,
        ));
}
