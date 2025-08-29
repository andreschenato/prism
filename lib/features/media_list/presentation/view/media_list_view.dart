import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart';

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
          children: [Expanded(child: _buildGrid(context, state, ref))],
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
  return GridView.builder(
    padding: EdgeInsets.zero,
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      crossAxisCount: 3,
      mainAxisExtent: 180,
    ),
    itemCount: state.media.length,
    itemBuilder: (context, index) {
      final media = state.media[index];
      return MediaCard(
        displayLabel: false,
        label: media.title,
        onPressed: () => context.go('/media/${media.id}'),
        iconPlaceholder: Icons.movie_creation_rounded,
        imageUrl: media.posterUrl,
      );
    },
  );
}
