import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class MediaListState {}

class MediaListInitial extends MediaListState {}
class MediaListLoading extends MediaListState {}
class MediaListLoaded extends MediaListState {
  final List<MediaEntity> media;
  MediaListLoaded(this.media);
}
class MediaListError extends MediaListState {
  final String message;
  MediaListError(this.message);
}
