import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import '../../data/llm_service.dart';
import '../../data/llm_recommendation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/features/media_list/presentation/view/media_grid_page.dart';

class RecommendationsResultView extends ConsumerStatefulWidget {
  const RecommendationsResultView({
    super.key,
    required this.genres,
    required this.countries,
    required this.eras,
    required this.languages,
  });

  final List<String> genres;
  final List<String> countries;
  final List<String> eras;
  final List<String> languages;

  @override
  ConsumerState<RecommendationsResultView> createState() =>
      _RecommendationsResultViewState();
}

class _RecommendationsResultViewState
    extends ConsumerState<RecommendationsResultView> {
  bool _loading = false;
  List<LlmRecommendation> _recommendations = [];

  Future<void> _fetchAndDisplayRecommendations() async {
    setState(() => _loading = true);

    final service = await LlmService.create();
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

      print('Received ${recs.length} recommendations from LLM');

      final mediaItems = recs
          .map((r) => {'id': r.id, 'type': r.type, 'title': r.title})
          .toList();

      print('Recommendations: $mediaItems');

      final mediaViewModel = ref.read(mediaListViewModelProvider.notifier);
      await mediaViewModel.fetchMediaFromRecommendations(mediaItems);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayRecommendations();
  }

  Widget _buildGrid(
    BuildContext context,
    MediaListLoaded state,
    WidgetRef ref,
  ) {
    final components = state.media.map((media) {
      return MediaCard(
        label: media.title,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MediaGridPage(title: media.title),
          ),
        ),
        iconPlaceholder: Icons.movie_creation_rounded,
        imageUrl: media.posterUrl ?? '',
        displayLabel: false,
      );
    }).toList();

    return HorizontalScrollList(components: components);
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
                onPressed: _loading ? null : _fetchAndDisplayRecommendations,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading) const Center(child: CircularProgressIndicator()),
            if (!_loading && _recommendations.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text('Recommendations', style: AppTextStyles.h2),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  itemCount: _recommendations.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (context, i) {
                    final r = _recommendations[i];
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
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Recommended for you', style: AppTextStyles.h2),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                MediaGridPage(title: 'Recommendations'),
                          ),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.primaryLight,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: _buildGrid(
                context,
                ref.watch(mediaListViewModelProvider) as MediaListLoaded,
                ref,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
