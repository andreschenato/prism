import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/locator.dart';
import 'package:prism/features/complete_profile/domain/repository/genres_repository.dart';
import 'package:prism/features/complete_profile/presentation/view_model/genres_state.dart';

final genresViewModelProvider =
    StateNotifierProvider.family<
      GenresViewModel,
      GenresState,
      (String, String)
    >((ref, params) {
      final lang = params.$1;
      final type = params.$2;
      return GenresViewModel(locator<GenresRepository>(), lang, type);
    });

class GenresViewModel extends StateNotifier<GenresState> {
  final GenresRepository _repository;

  GenresViewModel(this._repository, String lang, String type)
    : super(GenresInitial()) {
    getGenres(lang, type);
  }

  Future<void> getGenres(String lang, String type) async {
    try {
      state = GenresLoading();
      final genres = await _repository.getGenres(lang: lang, type: type);
      state = GenresLoaded(genres);
    } catch (error) {
      state = GenresError(error.toString());
    }
  }
}
