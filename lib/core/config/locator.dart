import 'package:get_it/get_it.dart';
import 'package:prism/features/details/data/repository/details_repository_impl.dart';
import 'package:prism/features/details/data/sources/details_api_source.dart';
import 'package:prism/features/details/domain/repository/details_repository.dart';
import 'package:prism/features/media_list/data/repository/media_repository_impl.dart';
import 'package:prism/features/media_list/data/sources/media_api_source.dart';
import 'package:prism/features/media_list/domain/repository/media_repository.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => MediaApiSource());
  locator.registerLazySingleton<MediaRepository>(
    () => MediaRepositoryImpl(locator<MediaApiSource>()),
  );
  locator.registerLazySingleton(() => DetailsApiSource());
  locator.registerLazySingleton<DetailsRepository>(
    () => DetailsRepositoryImpl(locator<DetailsApiSource>()),
  );
}
