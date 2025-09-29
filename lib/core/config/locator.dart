import 'package:get_it/get_it.dart';
import 'package:prism/features/auth/data/repository/auth_repository_impl.dart';
import 'package:prism/features/auth/data/sources/auth_api_source.dart';
import 'package:prism/features/auth/domain/repository/auth_repository.dart';
import 'package:prism/features/complete_profile/data/repository/complete_profile_repository_impl.dart';
import 'package:prism/features/complete_profile/data/repository/genres_repository_impl.dart';
import 'package:prism/features/complete_profile/data/sources/genres_source.dart';
import 'package:prism/features/complete_profile/data/sources/profile_firestore_source.dart';
import 'package:prism/features/complete_profile/domain/repository/complete_profile_repository.dart';
import 'package:prism/features/complete_profile/domain/repository/genres_repository.dart';
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
  locator.registerLazySingleton(() => AuthApiSource());
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(locator<AuthApiSource>()),
  );
  locator.registerLazySingleton(() => GenresSource());
  locator.registerLazySingleton<GenresRepository>(
    () => GenresRepositoryImpl(locator<GenresSource>()),
  );
  locator.registerLazySingleton(() => ProfileFirestoreSource());
  locator.registerLazySingleton<CompleteProfileRepository>(
    () => CompleteProfileRepositoryImpl(locator<ProfileFirestoreSource>()),
  );
}
