import 'package:prism/features/details/domain/entities/details_entity.dart';

abstract class DetailsRepository {
  Future<DetailsEntity> getMediaDetails(String id);
}