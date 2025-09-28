import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/list_builder.dart';
import 'package:prism/core/widgets/rounded_mini_card.dart';
import 'package:prism/features/complete_profile/presentation/view/complete_profile_view.dart';
import 'package:prism/features/complete_profile/presentation/view/select_language_country_view.dart'
    as selected_language;
import 'package:prism/features/complete_profile/presentation/view_model/genres_state.dart';
import 'package:prism/features/complete_profile/presentation/view_model/genres_view_model.dart';

final selectedGenresProvider = StateProvider<Map<String, Set<int>>?>(
  (ref) => null,
);

class SelectGenresView extends ConsumerStatefulWidget {
  final String type;
  final String title;
  const SelectGenresView({super.key, required this.type, required this.title});

  @override
  ConsumerState<SelectGenresView> createState() => _SelectGenreViewState();
}

class _SelectGenreViewState extends ConsumerState<SelectGenresView> {
  final ScrollController _scrollController = ScrollController();
  Set<int> _selectedGenreIds = {};

  @override
  void initState() {
    super.initState();
    final allSelectedGenres = ref.read(selectedGenresProvider);
    if (allSelectedGenres != null &&
        allSelectedGenres.containsKey(widget.type)) {
      _selectedGenreIds = Set<int>.from(allSelectedGenres[widget.type]!);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(selected_language.selectedLanguageProvider);
    final state = ref.watch(
      genresViewModelProvider((lang ?? 'en-US', widget.type)),
    );

    return _buildBody(context, state, ref);
  }

  Widget _buildBody(BuildContext context, GenresState state, WidgetRef ref) {
    if (state is GenresLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is GenresLoaded) {
      final index = ref.watch(completeProfileIndexProvider);

      return Column(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: AppTextStyles.h2.copyWith(
              color: AppColors.backgroundBlackDark,
            ),
          ),
          Expanded(child: _buildGrid(context, state)),
          Row(
            spacing: index >= 1 ? 20 : 0,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomButton(
                  label: 'Back',
                  reverseColors: true,
                  onPressed: () {
                    ref.read(completeProfileIndexProvider.notifier).state--;
                  },
                ),
              ),
              Expanded(
                child: CustomButton(
                  label: index < 2 ? 'Next' : 'Finish',
                  onPressed: _selectedGenreIds.length < 4
                      ? null
                      : () {
                          final currentSelectedGenres = ref.read(
                            selectedGenresProvider,
                          );

                          final newSelectedGenres = Map<String, Set<int>>.from(
                            currentSelectedGenres ?? {},
                          );
                          newSelectedGenres[widget.type] = _selectedGenreIds;

                          ref.read(selectedGenresProvider.notifier).state =
                              newSelectedGenres;

                          if (index < 2) {
                            ref
                                .read(completeProfileIndexProvider.notifier)
                                .state++;
                          }
                          if (index == 2) {
                            print(ref.read(selectedGenresProvider));
                          }
                        },
                ),
              ),
            ],
          ),
        ],
      );
    }
    if (state is GenresError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Error loading genres: ${state.message}')],
        ),
      );
    }
    return const Center(child: Text('Loading genres...'));
  }

  Widget _buildGrid(BuildContext context, GenresLoaded state) {
    return ListBuilder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        final genre = state.genres[index];
        final bool isSelected = _selectedGenreIds.contains(genre.id);
        return RoundedMiniCard(
          text: genre.name,
          color: isSelected
              ? AppColors.primaryDark
              : AppColors.backgroundWhiteLight,
          textColor: isSelected
              ? AppColors.backgroundWhiteLight
              : AppColors.backgroundBlackMedium,
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedGenreIds.remove(genre.id);
              } else {
                _selectedGenreIds.add(genre.id);
              }
            });
          },
        );
      },
      itemCount: state.genres.length,
      axisCount: 2,
      contentHeight: 32,
    );
  }
}
