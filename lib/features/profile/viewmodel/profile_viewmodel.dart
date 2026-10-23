import 'package:flutter/foundation.dart';

class ProfileViewModel extends ChangeNotifier {
  bool notificationsOn = true;

  void setNotifications(bool v) {
    notificationsOn = v;
    notifyListeners();
  }
}