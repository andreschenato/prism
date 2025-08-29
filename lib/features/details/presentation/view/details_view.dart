import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/features/details/presentation/view_model/details_state.dart';
import 'package:prism/features/details/presentation/view_model/details_view_model.dart';

class DetailsView extends ConsumerWidget {
  final String mediaId;
  const DetailsView(this.mediaId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detailsViewModelProvider(mediaId));

    return Scaffold(
      appBar: AppBar(),
      body: _buildBody(context, state, ref),
    );
  }

  Widget _buildBody(BuildContext context, DetailsState state, WidgetRef ref) {
    if (state is DetailsLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is DetailsLoaded) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.media.posterUrl != null)
              Center(
                child: Image.network(
                  state.media.posterUrl!,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              state.media.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ],
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
