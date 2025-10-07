import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/list_builder.dart';
import 'package:prism/core/widgets/media_card.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';

class MediaGridPage extends StatelessWidget {
  const MediaGridPage({
    super.key,
    required this.title,
    required this.media,
  });

  final String title;
  final List<MediaEntity> media;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListBuilder(
          itemBuilder: (context, index) {
            final item = media[index];
            return MediaCard(
              label: item.title,
              onPressed: () => context.go('/media/${item.id}'),
              iconPlaceholder: Icons.movie_creation_rounded,
              imageUrl: item.posterUrl,
            );
          },
          itemCount: media.length,
          axisCount: 3,
          contentHeight: 210,
        ),
      ),
    );
  }
}
