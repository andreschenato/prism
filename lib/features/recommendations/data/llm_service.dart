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
