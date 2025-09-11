import 'package:prism/features/details/domain/entities/details_entity.dart';

abstract class DetailsState {}

class DetailsInitial extends DetailsState {}
class DetailsLoading extends DetailsState {}
class DetailsLoaded extends DetailsState {
  final DetailsEntity media;
  DetailsLoaded(this.media);
}
class DetailsError extends DetailsState {
  final String message;
  DetailsError(this.message);
}
