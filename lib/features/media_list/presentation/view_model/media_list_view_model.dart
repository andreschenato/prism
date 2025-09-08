import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';

final mediaListViewModelProvider =
    StateNotifierProvider<MediaListViewModel, MediaListState>((ref) {
      return MediaListViewModel(locator<MediaRepository>());
    });

class MediaListViewModel extends StateNotifier<MediaListState> {
  final MediaRepository _repository;
  int _page = 1;
  bool _isLoading = false;

  MediaListViewModel(this._repository) : super(MediaListInitial()) {
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    if (_isLoading) return;
    _isLoading = true;

    try {
      if (_page == 1) {
        state = MediaListLoading();
      }

      final newMedia = await _repository.getMedia(page: _page);

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
      state = MediaListError(error.toString());
    } finally {
      _isLoading = false;
    }
  }
}
