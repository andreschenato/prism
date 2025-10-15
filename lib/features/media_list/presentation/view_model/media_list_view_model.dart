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

  MediaListViewModel(this._repository, {this.lang})
    : super(MediaListInitial()) {
    fetchMedia();
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

    print('Fetching media for recommendations: $recommendations');

    try {
      final recommendedMedia = await _repository.getMediaDetails(
        recommendations,
      );

      print('Fetched recommended media: $recommendedMedia');

      if (!mounted) return;

      final currentMedia = state is MediaListLoaded
          ? (state as MediaListLoaded).media
          : <MediaEntity>[];

      state = MediaListLoaded(currentMedia + recommendedMedia, hasMore: true);
    } catch (error) {
      if (mounted) {
        state = MediaListError(error.toString());
      }
    } finally {
      _isLoading = false;
    }
  }
}
