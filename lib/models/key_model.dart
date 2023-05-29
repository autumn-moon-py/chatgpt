import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RxKeyModel {
  RxString key = ''.obs;
  RxBool free = true.obs;
  SharedPreferences? local;

  Future<void> save() async {
    local = await SharedPreferences.getInstance();
    local?.setString('key', key.value);
    local?.setBool('free', free.value);
  }

  Future<void> load() async {
    local = await SharedPreferences.getInstance();
    key.value = local?.getString('key') ?? '';
    free.value = local?.getBool('free') ?? false;
  }
}
