import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/widgets/horizontal_scroll_list.dart';
import 'package:prism/core/widgets/media_details.dart';
import 'package:prism/core/widgets/mini_card.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';
import 'package:prism/features/details/presentation/view_model/details_view_model.dart';

class DetailsView extends ConsumerWidget {
  final String mediaId;
  const DetailsView(this.mediaId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailsViewModelProvider(mediaId));

    return Scaffold(appBar: AppBar(), body: _buildBody(context, state, ref));
  }

  Widget _buildBody(BuildContext context, DetailsState state, WidgetRef ref) {
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
              HorizontalScrollList(
                components: media.genres
                    .map((genre) => MiniCard(text: genre))
                    .toList(),
              ),
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
