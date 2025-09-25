import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/shell_view.dart';
import 'package:prism/features/auth/data/sources/auth_api_source.dart';
import 'package:prism/features/auth/presentation/view/login_view.dart';
import 'package:prism/features/auth/presentation/view/register_view.dart';
import 'package:prism/features/auth/presentation/view_model/auth_state.dart';
import 'package:prism/features/auth/presentation/view_model/auth_view_model.dart';
import 'package:prism/features/complete_profile/presentation/view/complete_profile_view.dart';
import 'package:prism/features/details/presentation/view/details_view.dart';
import 'package:prism/features/media_list/presentation/view/media_list_view.dart';

enum AppRoutes {
  mediaList,
  favorites,
  profile,
  login,
  register,
  completeProfile,
}

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authViewModelProvider);

  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/login',
        name: AppRoutes.login.name,
        builder: (context, state) => LoginView(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.register.name,
        builder: (context, state) => RegisterView(),
      ),
      GoRoute(
        path: '/complete_profile',
        name: AppRoutes.completeProfile.name,
        builder: (context, state) => CompleteProfileView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellView(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                name: AppRoutes.mediaList.name,
                builder: (context, state) =>
                    const Center(child: MediaListView()),
                routes: [
                  GoRoute(
                    path: 'media/:mediaId',
                    name: 'Details',
                    builder: (context, state) {
                      final mediaId = state.pathParameters['mediaId'];
                      return DetailsView(mediaId!);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/favorites',
                name: AppRoutes.favorites.name,
                builder: (context, state) => const Center(
                  child: Text('Favorites Page', style: TextStyle(fontSize: 24)),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                name: AppRoutes.profile.name,
                builder: (context, state) => Center(
                  child: CustomButton(
                    label:
                        'Logout ${authState is Authenticated ? authState.user.name : null}',
                    onPressed: () {
                      AuthApiSource().signOut();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLogged = authState is Authenticated;
      final loggingIn =
          state.matchedLocation == '/login' ||
          state.matchedLocation == '/register';

      if (!isLogged) {
        return loggingIn ? null : '/login';
      }

      if (isLogged && (authState.user.countryCode == null || authState.user.countryCode!.isEmpty)) {
        return '/complete_profile';
      }

      if (loggingIn) {
        return '/';
      }

      return null;
    },
  );
});
