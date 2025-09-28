import 'package:prism/features/complete_profile/domain/entities/genre_entity.dart';

abstract class GenresState {}

class GenresInitial extends GenresState {}

class GenresLoading extends GenresState {}

class GenresLoaded extends GenresState {
  final List<GenreEntity> genres;
  GenresLoaded(this.genres);
}

class GenresError extends GenresState {
  final String message;
  GenresError(this.message);
}
