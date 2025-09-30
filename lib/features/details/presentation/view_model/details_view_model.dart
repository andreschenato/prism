import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_state.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_view_model.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';

final detailsViewModelProvider =
    StateNotifierProvider.family<DetailsViewModel, DetailsState, String>((
      ref,
      mediaId,
    ) {
      final profileState = ref.watch(completeProfileProvider);
      String? language;
      if (profileState is ProfileSet) {
        language = profileState.user.language;
      }
      return DetailsViewModel(
        locator<DetailsRepository>(),
        mediaId,
        language: language,
      );
    });

class DetailsViewModel extends StateNotifier<DetailsState> {
  final DetailsRepository _repository;
  final String? language;

  DetailsViewModel(this._repository, String mediaId, {this.language})
    : super(DetailsInitial()) {
    fetchMedia(mediaId);
  }

  Future<void> fetchMedia(String id) async {
    try {
      state = DetailsLoading();
      final media = await _repository.getMediaDetails(id, language ?? 'en-US');

      if (!mounted) return;

      state = DetailsLoaded(media);
    } catch (error) {
      if (mounted) {
        state = DetailsError(error.toString());
      }
    }
  }
}
