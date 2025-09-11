import 'package:flutter/material.dart';

class ListBuilder extends StatelessWidget {
  final int axisCount;
  final double contentHeight;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  const ListBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.axisCount,
    required this.contentHeight,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        crossAxisCount: axisCount,
        mainAxisExtent: contentHeight,
      ),
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
