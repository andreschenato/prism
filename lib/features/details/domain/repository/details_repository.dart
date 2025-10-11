import 'package:prism/features/details/domain/entities/details_entity.dart';
import 'package:prism/features/media_list/domain/entities/media_entity.dart';

abstract class DetailsRepository {
  Future<DetailsEntity> getMediaDetails(String id, String lang, String type);
  Future<MediaEntity?> favoriteMedia(int id, String poster, String type, String title);
}
