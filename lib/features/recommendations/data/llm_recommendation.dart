class LlmRecommendation {
  final String title;
  final String id; // could be TMDB id or temporary id
  final String type; // 'movie' or 'tv'

  LlmRecommendation({
    required this.title,
    required this.id,
    required this.type,
  });

  factory LlmRecommendation.fromMap(Map<String, dynamic> m) {
    return LlmRecommendation(
      title: m['title']?.toString() ?? '',
      id: m['id']?.toString() ?? '',
      type: m['type']?.toString() ?? 'movie',
    );
  }
}
