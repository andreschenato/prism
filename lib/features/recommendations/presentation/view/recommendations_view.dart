import 'package:flutter/material.dart';
import 'package:prism/core/widgets/icon.dart';
import 'package:prism/features/recommendations/presentation/widgets/recommendations_section.dart';

class RecommendationsView extends StatelessWidget {
  const RecommendationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Get Recommendations")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsetsGeometry.all(40),
              child: StarIcon(icon: Icons.star, size: 40),
            ),

            RecommendationSection(
              title: "Genres",
              options: [
                "Drama",
                "Comédia",
                "Romance",
                "Suspense",
                "Ação",
                "Aventura",
                "Animação",
                "Documentário",
                "Musical",
              ],
            ),
            SizedBox(height: 24),
            RecommendationSection(
              title: "Nationalities",
              options: [
                "Brasileiro",
                "Americano",
                "Francês",
                "Japonês",
                "Coreano",
                "Italiano",
                "Alemão",
              ],
            ),
            SizedBox(height: 24),
            RecommendationSection(
              title: "Aesthetic Style",
              options: [
                "Minimalista",
                "Noir",
                "Cyberpunk",
                "Vintage",
                "Realista",
                "Surrealista",
              ],
            ),
          ],
        ),
      ),
    );
  }
}
