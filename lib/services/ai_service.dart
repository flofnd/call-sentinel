import 'package:http/http.dart' as http;

class AIService {
  Future<String> getSummary(String transcript) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer YOUR_OPENAI_API_KEY',
        'Content-Type': 'application/json',
      },
      body: '{"model":"gpt-4","messages":[{"role":"user","content":"Summarize: $transcript"}]}',
    );

    if (response.statusCode == 200) {
      return 'Summary generated';
    } else {
      throw Exception('Failed to get summary');
    }
  }
}
