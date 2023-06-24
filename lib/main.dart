import 'package:chatgpt/style/app_style.dart';
import 'package:chatgpt/pages/Home/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions();
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.maximize();
  });
  runApp(GetMaterialApp(
    home: const HomePage(),
    theme: AppStyle.defaultThemeData,
    debugShowCheckedModeBanner: false,
  ));
}
