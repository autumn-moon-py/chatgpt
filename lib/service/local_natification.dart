import 'package:local_notifier/local_notifier.dart';
import 'package:window_manager/window_manager.dart';

class LocalNotifier {
  Future<void> init() async {
    await localNotifier.setup(
      appName: 'chatgpt',
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  void show(String body) {
    LocalNotification notification = LocalNotification(
      title: '提醒',
      body: body,
    );
    notification.onShow = () {};
    notification.onClose = (_) {};
    notification.onClick = () async {
      await windowManager.show();
      await windowManager.maximize();
    };
    notification.onClickAction = (_) {};
    notification.show();
  }
}
