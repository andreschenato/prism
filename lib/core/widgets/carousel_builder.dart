import 'package:flutter/material.dart';

class CarouselBuilder extends StatelessWidget {
  final double height;
  final int itemCount;
  final Widget? Function(BuildContext, int) itemBuilder;
  const CarouselBuilder({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        scrollDirection: Axis.horizontal,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: itemBuilder(context, index),
          );
        },
      ),
    );
  }
}
