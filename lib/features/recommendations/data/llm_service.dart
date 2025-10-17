import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'llm_recommendation.dart';

class LlmService {
  LlmService._();

  static Future<LlmService> create() async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception('OPENROUTER_API_KEY not found in .env');
    return LlmService._();
  }

  Future<List<LlmRecommendation>> getRecommendationsFromPrompt(
    String prompt,
  ) async {
    final apiKey = dotenv.env['OPENROUTER_API_KEY'] ?? '';
    if (apiKey.isEmpty) throw Exception('OPENROUTER_API_KEY not found in .env');

    final uri = Uri.parse('https://openrouter.ai/api/v1/chat/completions');
    final body = json.encode({
      'model': 'google/gemini-2.0-flash-exp:free',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 800,
    });

    final res = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: body,
    );

    // print('OpenRouter response: ${res.body}');

    // final res =
    //     "{\"id\":\"gen-1760556967-iMGfatYhQ5nZCr1RiYe9\",\"provider\":\"Google AI Studio\",\"model\":\"google/gemini-2.0-flash-exp:free\",\"object\":\"chat.completion\",\"created\":1760556967,\"choices\":[{\"logprobs\":null,\"finish_reason\":\"stop\",\"native_finish_reason\":\"STOP\",\"index\":0,\"message\":{\"role\":\"assistant\",\"content\":\"[  {    \\\"title\\\": \\\"Cidade de Deus\\\",    \\\"id\\\": \\\"598\\\",    \\\"type\\\": \\\"movie\\\"  },  {    \\\"title\\\": \\\"Tropa de Elite\\\",    \\\"id\\\": \\\"7242\\\",    \\\"type\\\": \\\"movie\\\"  },  {    \\\"title\\\": \\\"Central do Brasil\\\",    \\\"id\\\": \\\"279\\\",    \\\"type\\\": \\\"movie\\\"  },  {    \\\"title\\\": \\\"O Quatrilho\\\",    \\\"id\\\": \\\"34882\\\",    \\\"type\\\": \\\"movie\\\"  }]\",\"refusal\":null,\"reasoning\":null}}],\"usage\":{\"prompt_tokens\":273,\"completion_tokens\":146,\"total_tokens\":419,\"prompt_tokens_details\":{\"cached_tokens\":0},\"completion_tokens_details\":{\"reasoning_tokens\":0,\"image_tokens\":0}}}";

    if (res.statusCode < 200 || res.statusCode >= 300) {
      throw Exception('OpenRouter API error: ${res.statusCode} ${res.body}');
    }

    final data = json.decode(res.body);
    String text = '';

    try {
      text = data['choices'][0]['message']['content'] ?? '';
    } catch (_) {
      throw Exception('Unexpected OpenRouter API response format');
    }

    // parse JSON array or fallback to lines
    try {
      final decoded = json.decode(text.isEmpty ? '[]' : text);
      if (decoded is List) {
        return decoded
            .map((e) => LlmRecommendation.fromMap(e as Map<String, dynamic>))
            .toList();
      }
    } catch (e) {
      final lines = text.split('\n').where((l) => l.trim().isNotEmpty).toList();
      return lines
          .map((l) => LlmRecommendation(title: l.trim(), id: '', type: 'movie'))
          .toList();
    }

    return [];
  }

  /// Load a prompt template from asset, inject the payload as JSON at placeholder {{payload}}
  Future<List<LlmRecommendation>> getRecommendationsFromTemplate({
    required Map<String, dynamic> payload,
    String assetPath = 'assets/recommendations_prompt.txt',
  }) async {
    final template = await rootBundle.loadString(assetPath);
    final injected = template.replaceAll('{{payload}}', json.encode(payload));
    return getRecommendationsFromPrompt(injected);
  }
}
