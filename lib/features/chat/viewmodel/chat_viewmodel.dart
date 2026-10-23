import 'package:flutter/foundation.dart';
import 'package:car_market_app/data/models/chat_message.dart';
import 'package:car_market_app/data/repositories/chat_repository.dart';

class ChatViewModel extends ChangeNotifier {
  final ChatRepository _repo;
  ChatViewModel(this._repo);

  String chatId = 'support';
  List<ChatMessage> messages = [];

  Future<void> open(String id) async {
    chatId = id;
    messages = await _repo.getMessages(id);
    notifyListeners();
  }

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;
    await _repo.sendMessage(
      chatId,
      ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: text.trim(),
        senderId: 'me',
        time: DateTime.now(),
      ),
    );
    messages = await _repo.getMessages(chatId);
    notifyListeners();
  }
}