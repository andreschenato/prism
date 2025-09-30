import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:prism/app.dart';
import 'package:prism/core/config/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/config/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initFirebase();
  setupLocator();
  runApp(const ProviderScope(child: PrismApp()));
}
