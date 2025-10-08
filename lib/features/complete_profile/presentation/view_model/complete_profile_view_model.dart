import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:prism/features/complete_profile/presentation/view_model/complete_profile_state.dart';

final completeProfileProvider =
    StateNotifierProvider<ProfileViewModel, ProfileState>((ref) {
      return ProfileViewModel(locator<CompleteProfileRepository>());
    });

class ProfileViewModel extends StateNotifier<ProfileState> {
  final CompleteProfileRepository _repository;

  ProfileViewModel(this._repository) : super(ProfileInitial()) {
    _repository.user.listen((user) {
      if (user?.countryCode != null &&
          user?.genreIds != null &&
          user?.language != null) {
        state = ProfileSet(user!);
      } else {
        state = ProfileNotSet();
      }
    });
  }

  Future<void> setUserProfilePreferences(
    Map<String, Set<int>> genreIds,
    String language,
    String country,
    String userId,
  ) async {
    try {
      state = ProfileLoading();
      final user = await _repository.setUserProfilePreferences(
        genreIds,
        country,
        language,
        userId,
      );
      state = ProfileSet(user!);
    } catch (e) {
      state = ProfileError(e.toString());
    }
  }
}
