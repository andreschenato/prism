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
        type: "list",
        isHomeProvider: true,
      );
    });

final favoritesListViewModelProvider =
    StateNotifierProvider.autoDispose<MediaListViewModel, MediaListState>((
      ref,
    ) {
      final profileState = ref.watch(completeProfileProvider);
      String? lang;
      if (profileState is ProfileSet) {
        lang = profileState.user.language;
      }
      return MediaListViewModel(
        repository: locator<MediaRepository>(),
        lang: lang,
        type: "favorites",
        isHomeProvider: true,
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
        isHomeProvider: false,
      );
    });

class MediaListViewModel extends StateNotifier<MediaListState> {
  final MediaRepository _repository;
  final String? lang;
  final String? type;
  final String? searchText;
  final bool _isHomeProvider;

  int _page = 1;
  bool _isLoading = false;
  String? _currentQuery;

  MediaListViewModel({
    required MediaRepository repository,
    this.lang,
    this.type,
    this.searchText,
    required bool isHomeProvider,
  }) : _repository = repository,
       _isHomeProvider = isHomeProvider,
       super(MediaListInitial()) {
    if (_isHomeProvider) {
      type == "favorites" ? fetchFavorites(text: searchText) : fetchMedia();
    }
  }

  Future<void> fetchMedia() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final currentMedia = state is MediaListLoaded
          ? (state as MediaListLoaded).media
          : <MediaEntity>[];

      if (_page == 1 && _currentQuery != null) {
        state = MediaListLoading();
      }

      final List<MediaEntity> newMedia;

      if (_currentQuery != null && _currentQuery!.isNotEmpty) {
        newMedia = await _repository.searchMedia(
          query: _currentQuery!,
          page: _page,
          lang: lang ?? 'en-US',
        );
      } else {
        newMedia = await _repository.getMedia(
          page: _page,
          lang: lang ?? 'en-US',
        );
      }

      if (!mounted) return;

      if (newMedia.isEmpty) {
        state = MediaListLoaded(currentMedia, hasMore: false);
      } else {
        _page++;
        final fullList = (_page == 2) ? newMedia : currentMedia + newMedia;
        state = MediaListLoaded(fullList, hasMore: true);
      }
    } catch (error) {
      if (mounted) {
        state = MediaListError(error.toString());
      }
    } finally {
      _isLoading = false;
    }
  }

  Future<void> fetchFavorites({String? text}) async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      final favorites = text != null && text.isNotEmpty
          ? await _repository.searchFavorite(text)
          : await _repository.getFavorites();

      if (!mounted) return;

      state = MediaListLoaded(favorites, hasMore: false);
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

  void resetState() {
    _page = 1;
    state = MediaListInitial();
  }

  Future<void> searchMedia(String query) async {
    if (_currentQuery == query) return;

    _page = 1;
    _currentQuery = query;
    state = MediaListLoading();
    await fetchMedia();
  }

  Future<void> clearSearch() async {
    if (_currentQuery == null) return;

    _page = 1;
    _currentQuery = null;
    state = MediaListLoading();
    await fetchMedia();
  }
}
