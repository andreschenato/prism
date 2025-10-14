import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import '../../data/llm_service.dart';
import '../../data/llm_recommendation.dart';

class RecommendationsResultView extends StatefulWidget {
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
  State<RecommendationsResultView> createState() =>
      _RecommendationsResultViewState();
}

class _RecommendationsResultViewState extends State<RecommendationsResultView> {
  bool _loading = false;
  List<LlmRecommendation> _results = [];

  Future<void> _requestRecommendations() async {
    setState(() => _loading = true);

    final service = await LlmService.create();

    // Build a prompt template; the user will provide detailed prompt in the prompt file
    final payload = {
      'genres': widget.genres,
      'countries': widget.countries,
      'eras': widget.eras,
      'languages': widget.languages,
    };

    try {
      final recs = await service.getRecommendationsFromTemplate(
        payload: payload,
      );
      setState(() {
        _results = recs;
      });
    } catch (e) {
      // handle error
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

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
            Text(
              'Genres: ${widget.genres.isEmpty ? 'Any' : widget.genres.join(', ')}',
            ),
            const SizedBox(height: 8),
            Text(
              'Countries: ${widget.countries.isEmpty ? 'Any' : widget.countries.join(', ')}',
            ),
            const SizedBox(height: 8),
            Text(
              'Eras: ${widget.eras.isEmpty ? 'Any' : widget.eras.join(', ')}',
            ),
            const SizedBox(height: 8),
            Text(
              'Languages: ${widget.languages.isEmpty ? 'Any' : widget.languages.join(', ')}',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.send),
                label: Text(
                  _loading
                      ? 'Requesting...'
                      : 'Get personalized recommendations',
                ),
                onPressed: _loading ? null : _requestRecommendations,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (!_loading && _results.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Recommendations', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: _results.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final r = _results[i];
                    return ListTile(
                      title: Text(r.title),
                      subtitle: Text('Type: ${r.type} id: ${r.id}'),
                      onTap: () {
                        // next step: lookup TMDB by title or id to fetch details
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
