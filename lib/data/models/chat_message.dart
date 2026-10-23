class ChatMessage {
  final String id, text, senderId;
  final DateTime time;
  const ChatMessage({required this.id, required this.text, required this.senderId, required this.time});

  factory ChatMessage.fromMap(String id, Map<String, dynamic> m) => ChatMessage(
        id: id,
        text: m['text'] ?? '',
        senderId: m['senderId'] ?? '',
        time: DateTime.fromMillisecondsSinceEpoch(m['time'] ?? 0),
      );

  Map<String, dynamic> toMap() => {'text': text, 'senderId': senderId, 'time': time.millisecondsSinceEpoch};
}