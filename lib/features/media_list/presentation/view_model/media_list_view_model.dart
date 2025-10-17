import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_state.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_view_model.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';

final mediaListViewModelProvider =
    StateNotifierProvider<MediaListViewModel, MediaListState>((ref) {
      final profileState = ref.watch(completeProfileProvider);
      String? lang;
      if (profileState is ProfileSet) {
        lang = profileState.user.language;
      }
      return MediaListViewModel(
        repository: locator<MediaRepository>(),
        lang: lang,
        isHomeProvider: true, // Identifica que é o provider da home
      );
    });

final recommendationsViewModelProvider =
    StateNotifierProvider<MediaListViewModel, MediaListState>((ref) {
      final profileState = ref.watch(completeProfileProvider);
      String? lang;
      if (profileState is ProfileSet) {
        lang = profileState.user.language;
      }
      return MediaListViewModel(
        repository: locator<MediaRepository>(),
        lang: lang,
        isHomeProvider: false, // Identifica que é o provider de recomendações
      );
    });

class MediaListViewModel extends StateNotifier<MediaListState> {
  final MediaRepository _repository;
  final String? lang;
  final bool _isHomeProvider;

  int _page = 1;
  bool _isLoading = false;

  MediaListViewModel({
    required MediaRepository repository,
    this.lang,
    required bool isHomeProvider,
  }) : _repository = repository,
       _isHomeProvider = isHomeProvider,
       super(MediaListInitial()) {
    // Só faz fetch automático se for o provider da home
    if (_isHomeProvider) {
      fetchMedia();
    }
  }

  Future<void> fetchMedia() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      if (_page == 1) {
        state = MediaListLoading();
      }

      final newMedia = await _repository.getMedia(
        page: _page,
        lang: lang ?? 'en-US',
      );

      if (!mounted) return;

      final currentMedia = state is MediaListLoaded
          ? (state as MediaListLoaded).media
          : <MediaEntity>[];

      if (newMedia.isEmpty) {
        state = MediaListLoaded(currentMedia, hasMore: false);
      } else {
        _page++;
        state = MediaListLoaded(currentMedia + newMedia, hasMore: true);
      }
    } catch (error) {
      if (mounted) {
        state = MediaListError(error.toString());
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchMediaFromRecommendations(
    List<Map<String, String>> recommendations,
  ) async {
    if (_isLoading) return;
    _isLoading = true;

    print('=== FETCHING RECOMMENDATIONS ===');
    print('Provider type: ${_isHomeProvider ? "HOME" : "RECOMMENDATIONS"}');
    print('Recommendations: $recommendations');

    try {
      state = MediaListLoading();

      final recommendedMedia = await _repository.getMediaDetails(
        recommendations,
      );

      print(
        'Successfully fetched ${recommendedMedia.length} recommended media',
      );
      for (final media in recommendedMedia) {
        print(
          '  - ${media.title} | Poster: ${media.posterUrl != null ? "YES" : "NO"}',
        );
      }

      if (!mounted) return;

      // SUBSTITUI a lista em vez de adicionar
      state = MediaListLoaded(recommendedMedia, hasMore: false);

      print(
        'Final state: MediaListLoaded with ${recommendedMedia.length} items',
      );
    } catch (error) {
      print('Error fetching recommendations: $error');
      if (mounted) {
        state = MediaListError(error.toString());
      }
    } finally {
      _isLoading = false;
    }
  }

  // Método para resetar completamente o estado
  void resetState() {
    _page = 1;
    state = MediaListInitial();
  }
}
