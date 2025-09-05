import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/social_login_button.dart';
import 'package:prism/core/widgets/text_input.dart';
import 'package:prism/features/auth/presentation/view_model/auth_view_model.dart';

class LoginView extends ConsumerWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Spacer(),
            Text('Login', style: AppTextStyles.h1),
            SocialLoginButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).signInWithGoogle();
              },
              asset: 'assets/google-logo.svg',
              label: 'Continue with Google',
            ),
            Text('or', style: AppTextStyles.bodyM),
            TextInput(label: 'Email', controller: _emailController),
            TextInput(
              label: 'Password',
              controller: _passwordController,
              hideInput: true,
            ),
            CustomButton(
              onPressed: () {
                ref
                    .read(authViewModelProvider.notifier)
                    .signIn(_emailController.text, _passwordController.text);
              },
              label: 'Login',
            ),
            Spacer(),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text(
                'Doesn\'t have an account? Register here',
                style: AppTextStyles.actionS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
