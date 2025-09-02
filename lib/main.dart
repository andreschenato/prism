import 'package:flutter/material.dart';
import 'package:prism/app.dart';
import 'package:prism/core/config/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  setupLocator();
  runApp(const ProviderScope(child: PrismApp()));
}
