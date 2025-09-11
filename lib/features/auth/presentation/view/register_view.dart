import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/button.dart';
import 'package:prism/core/widgets/social_login_button.dart';
import 'package:prism/core/widgets/text_input.dart';
import 'package:prism/features/auth/presentation/view_model/auth_view_model.dart';

class RegisterView extends ConsumerWidget {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  RegisterView({super.key});

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
            Text('Register', style: AppTextStyles.h1),
            SocialLoginButton(
              onPressed: () {
                ref.read(authViewModelProvider.notifier).signInWithGoogle();
              },
              asset: 'assets/google-logo.svg',
              label: 'Continue with Google',
            ),
            Text('or', style: AppTextStyles.bodyM),
            TextInput(label: 'Name', controller: _nameController),
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
                    .signUp(_emailController.text, _passwordController.text, _nameController.text);
              },
              label: 'Register',
            ),
            Spacer(),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text(
                'Already have an account? Login here',
                style: AppTextStyles.actionS,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
