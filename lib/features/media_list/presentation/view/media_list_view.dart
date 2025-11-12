import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/features/media_list/presentation/view/favorites_list_view.dart';
import 'package:prism/features/media_list/presentation/view/media_grid_page.dart';
import 'package:prism/features/recommendations/presentation/view/recommendations_wizard_view.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart'
    as providers;
import 'package:prism/core/theme/app_theme.dart';

class MediaListView extends ConsumerWidget {
  const MediaListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genericState = ref.watch(providers.mediaListViewModelProvider);
    final favoritesState = ref.watch(providers.favoritesListViewModelProvider);

    return Scaffold(
      body: _buildBody(context, genericState, favoritesState, ref),
    );
  }

  Widget _buildBody(
    BuildContext context,
    MediaListState genericState,
    MediaListState favoritesState,
    WidgetRef ref,
  ) {
    if (genericState is MediaListLoading ||
        favoritesState is MediaListLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (genericState is MediaListLoaded && favoritesState is MediaListLoaded) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, User!', style: AppTextStyles.h1),
            CustomButton(
              label: 'Get new recommendations',
              iconData: Icons.auto_awesome,
              width: 160,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RecommendationsWizardView(),
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Perfect for you', style: AppTextStyles.h2),

                      const Spacer(),

                      GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MediaGridPage(
                                title: 'All',
                                provider: providers.mediaListViewModelProvider,
                              ),
                            ),
                          );
                          ref
                              .read(
                                providers.mediaListViewModelProvider.notifier,
                              )
                              .clearSearch();
                        },
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: AppColors.primaryLight,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildGrid(context, genericState),
                ],
              ),
            ),
            Visibility(
              visible: favoritesState.media.isNotEmpty,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Your Favorites', style: AppTextStyles.h2),

                        const Spacer(),

                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    FavoritesListView(title: 'Your Favorites'),
                              ),
                            );
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                              color: AppColors.primaryLight,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildGrid(context, favoritesState),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (genericState is MediaListError && favoritesState is MediaListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error loading items: ${genericState.message} and ${favoritesState.message}',
            ),
          ],
        ),
      );
    }
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildGrid(BuildContext context, MediaListLoaded state) {
    final components = state.media.map((media) {
      return MediaCard(
        label: media.title,
        onPressed: () => context.go('/media/${media.id}?type=${media.type}'),
        iconPlaceholder: Icons.movie_creation_rounded,
        imageUrl: media.posterUrl,
        displayLabel: false,
      );
    }).toList();

    return SizedBox(
      height: 200,
      child: HorizontalScrollList(components: components),
    );
  }
}
