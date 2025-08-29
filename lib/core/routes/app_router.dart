import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/widgets/shell_view.dart';
import 'package:prism/features/details/presentation/view/details_view.dart';
import 'package:prism/features/media_list/presentation/view/media_list_view.dart';

enum AppRoutes { mediaList, favorites, profile }

final router = GoRouter(
  initialLocation: '/',
  routes: [
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
              builder: (context, state) => const Center(child: MediaListView()),
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
              builder: (context, state) => const Center(
                child: Text('Profile Page', style: TextStyle(fontSize: 24)),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);
