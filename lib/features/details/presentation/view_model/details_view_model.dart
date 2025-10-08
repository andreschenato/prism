import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_state.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_view_model.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';

class DetailsProviderParams {
  final String mediaId;
  final String type;

  const DetailsProviderParams({required this.mediaId, required this.type});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailsProviderParams &&
          runtimeType == other.runtimeType &&
          mediaId == other.mediaId &&
          type == other.type;

  @override
  int get hashCode => mediaId.hashCode ^ type.hashCode;
}

final detailsViewModelProvider =
    StateNotifierProvider.family<
      DetailsViewModel,
      DetailsState,
      DetailsProviderParams
    >((ref, params) {
      final profileState = ref.watch(completeProfileProvider);
      String? language;
      if (profileState is ProfileSet) {
        language = profileState.user.language;
      }
      return DetailsViewModel(
        locator<DetailsRepository>(),
        params,
        language: language,
      );
    });

class DetailsViewModel extends StateNotifier<DetailsState> {
  final DetailsRepository _repository;
  final String? language;

  DetailsViewModel(
    this._repository,
    DetailsProviderParams params, {
    this.language,
  }) : super(DetailsInitial()) {
    fetchMedia(params.mediaId, params.type);
  }

  Future<void> fetchMedia(String id, String type) async {
    try {
      state = DetailsLoading();
      final media = await _repository.getMediaDetails(
        id,
        language ?? 'en-US',
        type,
      );

      if (!mounted) return;

      state = DetailsLoaded(media);
    } catch (error) {
      if (mounted) {
        state = DetailsError(error.toString());
      }
    }
  }
}
