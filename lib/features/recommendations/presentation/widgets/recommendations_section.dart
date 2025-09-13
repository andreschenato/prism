import 'package:flutter/material.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/features/recommendations/presentation/widgets/recommendations_chip.dart';

class RecommendationSection extends StatefulWidget {
  final String title;
  final List<String> options;

  const RecommendationSection({
    super.key,
    required this.title,
    required this.options,
  });

  @override
  State<RecommendationSection> createState() => _RecommendationSectionState();
}

class _RecommendationSectionState extends State<RecommendationSection> {
  final Set<String> selectedItems = {};
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: 5000);
  }

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  double _calculateSpacing(String text, TextStyle style) {
    final tp = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    final width = tp.width;
    return (width * 1).clamp(1.0, 5.0);
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyMedium!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: AppTextStyles.h2),
        const SizedBox(height: 8),
        SizedBox(
          height: 150, // altura para 3 chips + espaçamento
          child: ListView.builder(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemCount: 10000,
            itemBuilder: (context, index) {
              final start = (index * 3) % widget.options.length;
              final chips = <Widget>[];

              for (int i = 0; i < 3; i++) {
                final item =
                    widget.options[(start + i) % widget.options.length];
                final spacing = _calculateSpacing(item, textStyle);

                chips.add(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RecommendationChip(
                        label: item,
                        selected: selectedItems.contains(item),
                        onTap: () => toggleSelection(item),
                      ),
                      if (i < 2) SizedBox(width: spacing),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: chips,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
