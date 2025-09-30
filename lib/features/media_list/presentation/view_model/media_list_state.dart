import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class MediaListState {}

class MediaListInitial extends MediaListState {}
class MediaListLoading extends MediaListState {}
class MediaListLoaded extends MediaListState {
  final List<MediaEntity> media;
  final bool hasMore;

  MediaListLoaded(this.media, {this.hasMore = true});
}
class MediaListError extends MediaListState {
  final String message;
  MediaListError(this.message);
}
