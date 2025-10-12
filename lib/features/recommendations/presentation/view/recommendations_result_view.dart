import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';

class RecommendationsResultView extends StatelessWidget {
  final List<String> genres;
  final List<String> countries;
  final List<String> eras;
  final List<String> languages;

  const RecommendationsResultView({
    super.key,
    required this.genres,
    required this.countries,
    required this.eras,
    required this.languages,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Summary', style: AppTextStyles.h2),
            const SizedBox(height: 12),
            Text('Genres: ${genres.isEmpty ? 'Any' : genres.join(', ')}'),
            const SizedBox(height: 8),
            Text(
              'Countries: ${countries.isEmpty ? 'Any' : countries.join(', ')}',
            ),
            const SizedBox(height: 8),
            Text('Eras: ${eras.isEmpty ? 'Any' : eras.join(', ')}'),
            const SizedBox(height: 8),
            Text(
              'Languages: ${languages.isEmpty ? 'Any' : languages.join(', ')}',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: const Text('Get personalized recommendations'),
                onPressed: () {
                  // Placeholder: here you'd call your backend / LLM to request recommendations.
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Request Sent'),
                      content: const Text(
                        'The preferences were sent to the recommendation service. (Placeholder)',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
