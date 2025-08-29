import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';

final detailsViewModelProvider =
    StateNotifierProvider.family<DetailsViewModel, DetailsState, String>((ref, mediaId) {
      return DetailsViewModel(locator<DetailsRepository>(), mediaId);
    });

class DetailsViewModel extends StateNotifier<DetailsState> {
  final DetailsRepository _repository;

  DetailsViewModel(this._repository, String mediaId) : super(DetailsInitial()) {
    fetchMedia(mediaId);
  }

  Future<void> fetchMedia(String id) async {
    try {
      state = DetailsLoading();
      final media = await _repository.getMediaDetails(id);
      state = DetailsLoaded(media);
    } catch (error) {
      state = DetailsError(error.toString());
    }
  }
}
