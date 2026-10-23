import 'package:car_market_app/data/models/chat_message.dart';

abstract class ChatRepository {
  Future<List<ChatMessage>> getMessages(String chatId);
  Future<void> sendMessage(String chatId, ChatMessage message);
}

class MockChatRepository implements ChatRepository {
  final Map<String, List<ChatMessage>> _store = {};

  @override
  Future<List<ChatMessage>> getMessages(String chatId) async => List.of(_store[chatId] ?? []);

  @override
  Future<void> sendMessage(String chatId, ChatMessage message) async {
    _store.putIfAbsent(chatId, () => []).add(message);
  }
}