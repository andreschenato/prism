// lib/features/user/presentation/user_page.dart
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/navigation_tile.dart';
import 'package:prism/features/auth/data/sources/auth_api_source.dart';

import 'account_details_view.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String? _username;
  StreamSubscription<User?>? _userChangesSubscription;

  @override
  void initState() {
    super.initState();
    _username = FirebaseAuth.instance.currentUser?.displayName;
    // Update the username whenever FirebaseAuth notifies listeners about changes.
    _userChangesSubscription = FirebaseAuth.instance.userChanges().listen((
      user,
    ) {
      final currentDisplayName = user?.displayName;
      if (!mounted || _username == currentDisplayName) {
        return;
      }
      setState(() {
        _username = currentDisplayName;
      });
    });
  }

  @override
  void dispose() {
    _userChangesSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  spacing: 10,
                  children: [
                    _Header(
                      username: _username,
                      onEditTap: () {
                        // TODO: abrir modal/rota para editar foto/nome
                      },
                    ),
                    GenericTile(
                      label: 'Account',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const AccountDetailsPage(),
                          ),
                        );
                      },
                    ),
                    GenericTile(
                      label: 'Notifications',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/notifications');
                      },
                    ),
                    GenericTile(
                      label: 'Appearance',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/appearance');
                      },
                    ),
                    GenericTile(
                      label: 'Informations',
                      color: AppColors.backgroundBlackDark,
                      icon: Icon(Icons.chevron_right),
                      onTap: () {
                        // TODO: push('/settings/informations');
                      },
                    ),
                  ],
                ),
              ),

              GenericTile(
                label: 'Logout',
                color: AppColors.errorDark,
                icon: Icon(Icons.logout),
                onTap: () {
                  AuthApiSource().signOut();
                },
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({this.username, this.onEditTap});

  final String? username;
  final VoidCallback? onEditTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 44,
              backgroundColor: AppColors.primaryDark,
              child: Icon(Icons.person, color: Colors.white, size: 48),
            ),
            Positioned(
              right: -2,
              bottom: -2,
              child: Material(
                color: Colors.white,
                shape: const CircleBorder(),
                elevation: 1,
                child: InkWell(
                  onTap: onEditTap,
                  customBorder: const CircleBorder(),
                  child: const Padding(
                    padding: EdgeInsets.all(6),
                    child: Icon(Icons.edit, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          username ?? '',
          style: AppTextStyles.h1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}


