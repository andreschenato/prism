import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/features/media_list/presentation/view/media_grid_page.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart';
import 'package:prism/core/theme/app_theme.dart';

class MediaListView extends ConsumerWidget {
  const MediaListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mediaListViewModelProvider);

    return Scaffold(body: _buildBody(context, state, ref));
  }

  Widget _buildBody(BuildContext context, MediaListState state, WidgetRef ref) {
    if (state is MediaListLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is MediaListLoaded) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          spacing: 20,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hi, User!', style: AppTextStyles.h1),
            CustomButton(label: 'Get new recommendations', iconData: Icons.auto_awesome, width: 160, onPressed: () => {}),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Perfect for you', style: AppTextStyles.h2),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MediaGridPage(
                              title: 'Recommendations',
                              media: state.media,
                            ),
                          ),
                        );
                      },
                      child: Text('See all', style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ],
                ),
              ),
            ),
            _buildGrid(context, state, ref),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Your Favorites', style: AppTextStyles.h2),

                    const Spacer(),

                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MediaGridPage(
                              title: 'Your Favorites',
                              media: state.media,
                            ),
                          ),
                        );
                      },
                      child: Text('See all', style: TextStyle(
                        color: AppColors.primaryLight,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                  ],
                ),
              ),
            ),
            _buildGrid(context, state, ref),
          ],
        ),
      );
    }
    if (state is MediaListError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Error loading items: ${state.message}')],
        ),
      );
    }
    return const Center(child: Text('Press button to load more media'));
  }
}

Widget _buildGrid(BuildContext context, MediaListLoaded state, WidgetRef ref) {
  final components = state.media.map((media) {
    return MediaCard(
      label: media.title,
      onPressed: () => context.go('/media/${media.id}'),
      iconPlaceholder: Icons.movie_creation_rounded,
      imageUrl: media.posterUrl,
      displayLabel: false,
    );
  }).toList();

  return SizedBox(
    height: 200,
    child: HorizontalScrollList(
      components: components,
    ),
  );
}
