import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel _model;

  GeminiService({required String apiKey})
      : _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

  Future<String> ask(String prompt) async {
    final response = await _model.generateContent([Content.text(prompt)]);
    return response.text ?? 'No response generated.';
  }

  Future<String> summarizePullRequest(String diff) {
    return ask('Summarize this pull request diff in three bullet points:\n$diff');
  }
}
