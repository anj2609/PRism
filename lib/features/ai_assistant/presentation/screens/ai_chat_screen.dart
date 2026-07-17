import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ai_chat_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class AiChatScreen extends ConsumerStatefulWidget {
  const AiChatScreen({super.key});

  @override
  ConsumerState<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends ConsumerState<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();

  final List<String> _suggestions = const [
    'Summarize today\'s work',
    'Explain PR #212',
    'What changed in Login?',
    'Any risky commits today?',
  ];

  void _send(String text) {
    if (text.trim().isEmpty) return;
    ref.read(aiChatProvider.notifier).send(text.trim());
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(aiChatProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('AI Assistant')),
      body: Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text('Try asking', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _suggestions
                            .map((suggestion) => ActionChip(label: Text(suggestion), onPressed: () => _send(suggestion)))
                            .toList(),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: const EdgeInsets.all(12),
                          constraints: const BoxConstraints(maxWidth: 280),
                          decoration: BoxDecoration(
                            color: message.isUser ? AppColors.primary : theme.cardColor,
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            message.text,
                            style: AppTextStyles.body(message.isUser ? Colors.white : theme.colorScheme.onSurface),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _send,
                    decoration: InputDecoration(
                      hintText: 'Ask about your GitHub activity',
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => _send(_controller.text),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
