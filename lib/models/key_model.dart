import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KeyModel {
  RxString key = ''.obs;
  SharedPreferences? local;

  Future<void> save(String key) async {
    local = await SharedPreferences.getInstance();
    local?.setString('key', key);
  }

  Future<void> load() async {
    local = await SharedPreferences.getInstance();
    key.value = local?.getString('key') ?? '';
  }
}
