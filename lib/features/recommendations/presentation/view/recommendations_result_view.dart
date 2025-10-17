import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import '../../data/llm_service.dart';
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

      // Reseta o provider antes de buscar novas recomendações
      ref.invalidate(recommendationsViewModelProvider);

      final recommendationsViewModel = ref.read(
        recommendationsViewModelProvider.notifier,
      );
      await recommendationsViewModel.fetchMediaFromRecommendations(mediaItems);

      // Debug: verifique o estado atual
      final currentState = ref.read(recommendationsViewModelProvider);
      if (currentState is MediaListLoaded) {
        print('Successfully loaded ${currentState.media.length} media items');
        for (final media in currentState.media) {
          print('  - ${media.title} | Poster: ${media.posterUrl ?? "NO"}');
        }
      }
    } catch (e) {
      print('Error fetching recommendations: $e');
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchAndDisplayRecommendations();
    });
  }

  Widget _buildRecommendationsGrid(
    BuildContext context,
    List<MediaEntity> mediaList,
  ) {
    if (mediaList.isEmpty) {
      return const SizedBox.shrink();
    }

    final components = mediaList.map((media) {
      return MediaCard(
        label: media.title,
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MediaGridPage(
              title: media.title,
              provider: recommendationsViewModelProvider,
            ),
          ),
        ),
        iconPlaceholder: Icons.movie_creation_rounded,
        imageUrl: media.posterUrl ?? '',
        displayLabel: false,
      );
    }).toList();

    return HorizontalScrollList(components: components);
  }

  Widget _buildContent() {
    final state = ref.watch(recommendationsViewModelProvider);

    // Debug do estado
    print('Current recommendations state: ${state.runtimeType}');
    if (state is MediaListLoaded) {
      print('Media list length: ${state.media.length}');
    }

    return Column(
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
        Text('Eras: ${widget.eras.isEmpty ? 'Any' : widget.eras.join(', ')}'),
        const SizedBox(height: 8),
        Text(
          'Languages: ${widget.languages.isEmpty ? 'Any' : widget.languages.join(', ')}',
        ),
        const SizedBox(height: 24),
        Center(
          child: ElevatedButton.icon(
            icon: const Icon(Icons.send),
            label: Text(
              _loading ? 'Requesting...' : 'Get personalized recommendations',
            ),
            onPressed: _loading ? null : _fetchAndDisplayRecommendations,
          ),
        ),
        const SizedBox(height: 16),

        if (_loading) const Center(child: CircularProgressIndicator()),

        if (!_loading &&
            state is MediaListLoaded &&
            state.media.isNotEmpty) ...[
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
                          builder: (context) => MediaGridPage(
                            title: 'Recommendations',
                            provider: recommendationsViewModelProvider,
                          ),
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
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: _buildRecommendationsGrid(context, state.media),
          ),
        ],

        if (!_loading && state is MediaListLoaded && state.media.isEmpty)
          const Center(child: Text('No recommendations found')),

        if (!_loading && state is MediaListError)
          Center(child: Text('Error: ${state.message}')),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildContent(),
      ),
    );
  }
}
