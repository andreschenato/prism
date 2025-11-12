import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';
import 'package:prism/core/widgets/horizontal_scroll_section.dart';
import 'package:prism/core/widgets/icon_button.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/core/widgets/media_details.dart';
import 'package:prism/core/widgets/mini_card.dart';
import 'package:prism/features/details/domain/entities/details_entity.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';
import 'package:prism/features/details/presentation/view_model/details_view_model.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart';

class DetailsView extends ConsumerWidget {
  final String mediaId;
  final String type;
  const DetailsView(this.mediaId, this.type, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = DetailsProviderParams(mediaId: mediaId, type: type);
    final state = ref.watch(detailsViewModelProvider(params));

    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: _buildBody(context, state, ref, params),
    );
  }

  Widget _buildBody(
    BuildContext context,
    DetailsState state,
    WidgetRef ref,
    DetailsProviderParams params,
  ) {
    if (state is DetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is DetailsLoaded) {
      var media = state.media;

      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MediaDetails(
                title: media.title,
                imageUrl: media.posterUrl,
                startYear: media.startYear,
                endYear: media.endYear,
                directors: media.directors
                    .map((director) => director.name)
                    .toList(),
                writers: media.writers.map((writer) => writer.name).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomIconButton(
                    color: media.isFavorite! ? AppColors.primaryDark : null,
                    icon: Icons.favorite,
                    onPressed: () {
                      ref
                          .read(detailsViewModelProvider(params).notifier)
                          .favoriteMedia(
                            media.posterUrl!,
                            media.id,
                            type,
                            media.title,
                          );

                      ref.invalidate(favoritesListViewModelProvider);
                    },
                    label: 'Favorite',
                  ),
                  CustomIconButton(
                    icon: Icons.movie,
                    onPressed: () {
                      // TODO: Implement trailer functionality
                    },
                    label: 'Trailer',
                  ),
                  CustomIconButton(
                    icon: Icons.share,
                    onPressed: () {
                      // TODO: Implement share functionality
                    },
                    label: 'Share',
                  ),
                ],
              ),
              HorizontalScrollList(
                components: media.genres
                    .map((genre) => MiniCard(text: genre))
                    .toList(),
              ),
              SizedBox(
                height: 100,
                child: Text(media.plot, style: AppTextStyles.bodyXS),
              ),
              ..._buildSections(media),
            ],
          ),
        ),
      );
    }
    if (state is DetailsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Error loading item: ${state.message}')],
        ),
      );
    }
    return const Center(child: Text('Loading details...'));
  }
}

List<Widget> _buildSections(DetailsEntity media) {
  var seasonsWidget = media.seasons != null
      ? HorizontalScrollSection(
          title: 'Seasons',
          components: media.seasons!
              .map(
                (season) => MediaCard(
                  label: season.name,
                  imageUrl: season.photo,
                  onPressed: () {},
                  iconPlaceholder: Icons.tv_rounded,
                ),
              )
              .toList(),
        )
      : Placeholder();
  return [
    Visibility(visible: media.seasons != null, child: seasonsWidget),
    HorizontalScrollSection(
      title: 'Actors',
      components: media.actors
          .map(
            (actor) => MediaCard(
              label: actor.name,
              onPressed: () {},
              iconPlaceholder: Icons.person_rounded,
              imageUrl: actor.photo,
              subTitle: actor.character,
            ),
          )
          .toList(),
    ),
  ];
}
