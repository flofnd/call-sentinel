import 'dart:convert';
import 'package:http/http.dart' as http;

class AISummaryService {
  static const _apiKey = '';
  static const _apiUrl = 'https://api.openai.com/v1/chat/completions';

  static Future<String> generateSummary(String transcript) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "gpt-4",
          "messages": [
            {
              "role": "system",
              "content": "You are a helpful assistant summarizing phone calls."
            },
            {
              "role": "user",
              "content": "Summarize this call transcript in 1 sentence: $transcript"
            }
          ],
          "temperature": 0.5,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].trim();
      } else {
        print("GPT Error: ${response.body}");
        return "Error: Could not generate summary.";
      }
    } catch (e) {
      print("GPT Exception: $e");
      return "Error: Summary generation failed.";
    }
  }
}
