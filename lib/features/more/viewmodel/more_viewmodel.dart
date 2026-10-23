import 'package:flutter/foundation.dart';

/// About, Terms, Privacy aur FAQs ka static content yahan se aayega.
class MoreViewModel extends ChangeNotifier {
  String pageTitle = '';
  String pageBody = '';

  void openPage(String title, String body) {
    pageTitle = title;
    pageBody = body;
    notifyListeners();
  }
}