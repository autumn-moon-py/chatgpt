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
    notification.onClose = (closeReason) {
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
          break;
        case LocalNotificationCloseReason.timedOut:
          break;
        default:
      }
    };
    notification.onClick = () async {
      await windowManager.show();
      await windowManager.focus();
    };
    notification.onClickAction = (actionIndex) {};
    notification.show();
  }
}
