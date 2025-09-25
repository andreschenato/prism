import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/dropdown.dart';
import 'package:prism/features/auth/presentation/view_model/auth_state.dart';
import 'package:prism/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:prism/features/complete_profile/data/sources/country_source.dart';

final selectedLanguageProvider = StateProvider<String?>((ref) => null);
final selectedCountryProvider = StateProvider<String?>((ref) => null);

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

    final selectedCountry = ref.watch(selectedCountryProvider);

    final List<DropdownMenuEntry<String>> countryEntries = countryCodes.map((
      String code,
    ) {
      return DropdownMenuEntry<String>(
        value: code,
        label: code,
        leadingIcon: CountryFlag.fromCountryCode(
          code,
          theme: ImageTheme(height: 18, width: 24, shape: RoundedRectangle(4)),
        ),
      );
    }).toList();

    Widget? countryFlagIcon;
    if (selectedCountry != null && selectedCountry.isNotEmpty) {
      countryFlagIcon = _flagIcon(selectedCountry);
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
              Text(
                'Language & Localization',
                style: AppTextStyles.h2.copyWith(
                  color: AppColors.backgroundBlackDark,
                ),
              ),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Dropdown(
                      label: 'Language',
                      onSelected: (String? newValue) {
                        ref.read(selectedLanguageProvider.notifier).state =
                            newValue;
                      },
                      entries: languages,
                    ),
                  ),
                  Expanded(
                    child: Dropdown(
                      leadingIcon: countryFlagIcon,
                      label: 'Country',
                      onSelected: (String? newValue) {
                        ref.read(selectedCountryProvider.notifier).state =
                            newValue;
                      },
                      entries: countryEntries,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _flagIcon(String selectedCountry) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CountryFlag.fromCountryCode(
        selectedCountry,
        theme: ImageTheme(height: 18, width: 24, shape: RoundedRectangle(4)),
      ),
    ],
  );
}
