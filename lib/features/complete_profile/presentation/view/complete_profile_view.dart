import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/features/auth/presentation/view_model/auth_state.dart';
import 'package:prism/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:prism/features/complete_profile/presentation/view/select_genres_view.dart';
import 'package:prism/features/complete_profile/presentation/view/select_language_country_view.dart';

final selectedLanguageProvider = StateProvider<String?>((ref) => null);
final selectedCountryProvider = StateProvider<String?>((ref) => null);
final completeProfileIndexProvider = StateProvider<int>((ref) => 0);

class CompleteProfileView extends ConsumerWidget {
  CompleteProfileView({super.key});

  final List<DropdownMenuEntry<String>> languages = [
    DropdownMenuEntry(value: 'pt-BR', label: 'Português Brasil'),
    DropdownMenuEntry(value: 'en-US', label: 'English US'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authViewModelProvider);
    if (authState is! Authenticated) {
      return const Scaffold(
        body: Center(child: Text('User not authenticated')),
      );
    }

    final index = ref.watch(completeProfileIndexProvider);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            spacing: 20,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Complete Your Profile',
                style: AppTextStyles.h1.copyWith(
                  color: AppColors.backgroundBlackDark,
                ),
              ),
              Expanded(
                flex: 4,
                child: IndexedStack(
                  index: index,
                  children: [
                    SelectLanguageCountryView(),
                    SelectGenresView(type: 'movie', title: 'Movie Genres'),
                    SelectGenresView(type: 'tv', title: 'TV Genres'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
