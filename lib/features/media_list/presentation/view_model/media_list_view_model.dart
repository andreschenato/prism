import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';

final mediaListViewModelProvider =
    StateNotifierProvider<MediaListViewModel, MediaListState>((ref) {
      return MediaListViewModel(locator<MediaRepository>());
    });

class MediaListViewModel extends StateNotifier<MediaListState> {
  final MediaRepository _repository;

  MediaListViewModel(this._repository) : super(MediaListInitial()) {
    fetchMedia();
  }

  Future<void> fetchMedia() async {
    try {
      state = MediaListLoading();
      final media = await _repository.getMedia();
      state = MediaListLoaded(media);
    } catch (error) {
      state = MediaListError(error.toString());
    }
  }
}
