import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/list_builder.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/core/widgets/search_bar.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_state.dart';
import 'package:prism/features/media_list/presentation/view_model/media_list_view_model.dart';

class MediaGridPage extends ConsumerStatefulWidget {
  const MediaGridPage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<MediaGridPage> createState() => _MediaGridPageState();
}

class _MediaGridPageState extends ConsumerState<MediaGridPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100) {
      ref.read(mediaListViewModelProvider.notifier).fetchMedia();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mediaListViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: CustomSearchBar(
              controller: _searchController,
              hintText: 'Search ${widget.title}',
              onChanged: (value) {
                // TODO: Implement search functionality
                print('Search query: $value');
                if (value.isEmpty) {
                  ref.read(mediaListViewModelProvider.notifier).clearSearch();
                }
              },
              onSubmitted: (value) {
                print('Search submitted: $value');
                if (value.isNotEmpty) {
                  ref.read(mediaListViewModelProvider.notifier).searchMedia(value);
                }
              },
            ),
          ),
          Expanded(child: _buildBody(context, state)),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MediaListState state) {
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
          children: [Expanded(child: _buildGrid(context, state))],
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

  Widget _buildGrid(BuildContext context, MediaListLoaded state) {
    return ListBuilder(
      controller: _scrollController,
      itemBuilder: (context, index) {
        final media = state.media[index];
        return MediaCard(
          label: media.title,
          onPressed: () => context.go('/media/${media.id}?type=${media.type}'),
          iconPlaceholder: Icons.movie_creation_rounded,
          imageUrl: media.posterUrl,
          displayLabel: false,
        );
      },
      itemCount: state.media.length,
      axisCount: 3,
      contentHeight: 180,
    );
  }
}
