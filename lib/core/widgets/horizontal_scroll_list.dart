import 'package:flutter/material.dart';

class HorizontalScrollList extends StatelessWidget {
  final List components;
  const HorizontalScrollList({super.key, required this.components});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(spacing: 10, children: List.from(components)),
    );
  }
}
