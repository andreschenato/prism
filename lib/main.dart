import 'package:flutter/material.dart';
import 'package:prism/app.dart';
import 'package:prism/core/config/firebase_options.dart';
import 'package:prism/core/config/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const ProviderScope(child: PrismApp()));
}
