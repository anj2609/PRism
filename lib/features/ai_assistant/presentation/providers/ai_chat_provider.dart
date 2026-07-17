import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatMessage {
  final String text;
  final bool isUser;

  const ChatMessage({required this.text, required this.isUser});
}

class AiChatNotifier extends StateNotifier<List<ChatMessage>> {
  AiChatNotifier() : super([]);

  Future<void> send(String prompt) async {
    state = [...state, ChatMessage(text: prompt, isUser: true)];
    await Future.delayed(const Duration(milliseconds: 500));
    state = [...state, ChatMessage(text: _mockReply(prompt), isUser: false)];
  }

  String _mockReply(String prompt) {
    if (prompt.toLowerCase().contains('summarize')) {
      return 'You merged 3 PRs, reviewed 5, opened 2 issues. Failed builds: 1.';
    }
    if (prompt.toLowerCase().contains('explain')) {
      return 'This PR adds Google OAuth login using Firebase Authentication.';
    }
    if (prompt.toLowerCase().contains('risky')) {
      return 'No risky commits detected today.';
    }
    return 'Here is what I found based on your GitHub activity.';
  }
}

final aiChatProvider = StateNotifierProvider<AiChatNotifier, List<ChatMessage>>((ref) {
  return AiChatNotifier();
});
