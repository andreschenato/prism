import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'recommendations_result_view.dart';

final _genresProvider = StateProvider<List<String>>((ref) => []);
final _countriesProvider = StateProvider<List<String>>((ref) => []);
final _erasProvider = StateProvider<List<String>>((ref) => []);
final _languagesProvider = StateProvider<List<String>>((ref) => []);

class RecommendationsWizardView extends ConsumerStatefulWidget {
  const RecommendationsWizardView({super.key});

  @override
  ConsumerState<RecommendationsWizardView> createState() =>
      _RecommendationsWizardViewState();
}

class _RecommendationsWizardViewState
    extends ConsumerState<RecommendationsWizardView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _next() {
    if (_currentIndex < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = _currentIndex + 1);
    }
  }

  void _previous() {
    if (_currentIndex > 0) {
      _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentIndex = _currentIndex - 1);
    }
  }

  Widget _multiSelectChip(
    List<String> options,
    List<String> selected,
    void Function(String) toggle,
  ) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: options.map((opt) {
        final chosen = selected.contains(opt);
        return FilterChip(
          selected: chosen,
          label: Text(opt),
          onSelected: (_) => toggle(opt),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final genres = ref.watch(_genresProvider);
    final countries = ref.watch(_countriesProvider);
    final eras = ref.watch(_erasProvider);
    final languages = ref.watch(_languagesProvider);

    // Example option lists - you can replace with dynamic data
    final genreOptions = [
      'Action',
      'Comedy',
      'Drama',
      'Horror',
      'Sci-Fi',
      'Romance',
      'Documentary',
    ];
    final countryOptions = [
      'USA',
      'UK',
      'Brazil',
      'France',
      'Japan',
      'India',
      'South Korea',
    ];
    final eraOptions = [
      'Before 1980',
      '1980s',
      '1990s',
      '2000s',
      '2010s',
      '2020s',
      'Any',
    ];
    final languageOptions = [
      'English',
      'Portuguese',
      'Spanish',
      'French',
      'Japanese',
      'Korean',
      'Any',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Recommendations Wizard')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentIndex = i),
                children: [
                  // Step 1: Genres
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step 1 of 4', style: AppTextStyles.h3),
                      const SizedBox(height: 8),
                      Text('Select preferred genres', style: AppTextStyles.h2),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _multiSelectChip(genreOptions, genres, (g) {
                            final list = List<String>.from(
                              ref.read(_genresProvider),
                            );
                            if (list.contains(g)) {
                              list.remove(g);
                            } else {
                              list.add(g);
                            }
                            ref.read(_genresProvider.notifier).state = list;
                          }),
                        ),
                      ),
                    ],
                  ),

                  // Step 2: Countries
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step 2 of 4', style: AppTextStyles.h3),
                      const SizedBox(height: 8),
                      Text(
                        'Select preferred production countries',
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _multiSelectChip(countryOptions, countries, (
                            c,
                          ) {
                            final list = List<String>.from(
                              ref.read(_countriesProvider),
                            );
                            if (list.contains(c)) {
                              list.remove(c);
                            } else {
                              list.add(c);
                            }
                            ref.read(_countriesProvider.notifier).state = list;
                          }),
                        ),
                      ),
                    ],
                  ),

                  // Step 3: Era
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step 3 of 4', style: AppTextStyles.h3),
                      const SizedBox(height: 8),
                      Text('Select eras / decades', style: AppTextStyles.h2),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _multiSelectChip(eraOptions, eras, (e) {
                            final list = List<String>.from(
                              ref.read(_erasProvider),
                            );
                            if (list.contains(e)) {
                              list.remove(e);
                            } else {
                              list.add(e);
                            }
                            ref.read(_erasProvider.notifier).state = list;
                          }),
                        ),
                      ),
                    ],
                  ),

                  // Step 4: Languages
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Step 4 of 4', style: AppTextStyles.h3),
                      const SizedBox(height: 8),
                      Text(
                        'Select preferred audio/subtitle languages',
                        style: AppTextStyles.h2,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: SingleChildScrollView(
                          child: _multiSelectChip(languageOptions, languages, (
                            l,
                          ) {
                            final list = List<String>.from(
                              ref.read(_languagesProvider),
                            );
                            if (list.contains(l)) {
                              list.remove(l);
                            } else {
                              list.add(l);
                            }
                            ref.read(_languagesProvider.notifier).state = list;
                          }),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    if (_currentIndex == 0) {
                      Navigator.of(context).pop();
                      return;
                    }
                    _previous();
                  },
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_currentIndex < 3) {
                      _next();
                    } else {
                      // Collect selections and navigate to result / summary
                      final selGenres = ref.read(_genresProvider);
                      final selCountries = ref.read(_countriesProvider);
                      final selEras = ref.read(_erasProvider);
                      final selLanguages = ref.read(_languagesProvider);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => RecommendationsResultView(
                            genres: selGenres,
                            countries: selCountries,
                            eras: selEras,
                            languages: selLanguages,
                          ),
                        ),
                      );
                    }
                  },
                  child: Text((_currentIndex < 3) ? 'Next' : 'Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
