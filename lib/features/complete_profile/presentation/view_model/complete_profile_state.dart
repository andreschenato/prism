import 'package:prism/features/auth/domain/entities/user_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileSet extends ProfileState {
  final UserEntity user;
  ProfileSet(this.user);
}

class ProfileLoading extends ProfileState {}

class ProfileNotSet extends ProfileState {}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}
