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
      if (user != null) {
        state = ProfileSet(user);
      } else {
        state = ProfileNotSet();
      }
    });
  }
}
