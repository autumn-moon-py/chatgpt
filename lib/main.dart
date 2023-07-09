import 'package:chatgpt/home/view.dart';
import 'package:chatgpt/style/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:window_manager/window_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions();
  await windowManager.ensureInitialized();
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
