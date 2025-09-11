import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/card_image.dart';
import 'package:prism/core/widgets/person_detail.dart';

class MediaDetails extends StatelessWidget {
  final String? imageUrl;
  final String title;
  final int startYear;
  final int? endYear;
  final List directors;
  final List writers;
  const MediaDetails({
    super.key,
    this.imageUrl,
    required this.title,
    required this.startYear,
    this.endYear,
    required this.directors,
    required this.writers,
  });

  @override
  Widget build(BuildContext context) {
    String runningDate = endYear == null
        ? '$startYear'
        : '$startYear - $endYear';

    return SizedBox(
      height: 160,
      width: 350,
      child: Row(
        spacing: 15,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              width: 120,
              child: Material(
                child: CardImage(
                  iconPlaceholder: Icons.movie_creation_rounded,
                  imageUrl: imageUrl,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.h3, softWrap: true),
                Text(runningDate, style: AppTextStyles.bodyXS),
                PersonDetail(icon: Icons.video_camera_front_rounded, persons: directors as List<String>),
                PersonDetail(icon: Icons.note_alt_rounded, persons: writers as List<String>),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
