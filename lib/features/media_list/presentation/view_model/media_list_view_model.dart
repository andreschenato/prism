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
      return MediaListViewModel(locator<MediaRepository>(), lang: lang);
    });

class MediaListViewModel extends StateNotifier<MediaListState> {
  final MediaRepository _repository;
  final String? lang;
  int _page = 1;
  bool _isLoading = false;
  String? _currentQuery;

  MediaListViewModel(this._repository, {this.lang})
    : super(MediaListInitial()) {
    fetchMedia();
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
        // Lógica de busca
        newMedia = await _repository.searchMedia(
          query: _currentQuery!,
          page: _page,
          lang: lang ?? 'en-US',
        );
      } else {
        // Lógica padrão de carregar mídia
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
        final fullList = (_page == 2) // Page foi incrementada, então checamos se era a primeira
            ? newMedia
            : currentMedia + newMedia;
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
