class AIMessage {
  final String message;
  final bool isUser;
  final DateTime time;

  AIMessage({
    required this.message,
    required this.isUser,
    required this.time,
  });
}