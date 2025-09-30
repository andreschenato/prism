import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prism/core/theme/app_theme.dart';
import 'package:prism/core/widgets/editable_card.dart';

class AccountDetailsPage extends StatefulWidget {
  const AccountDetailsPage({super.key});

  @override
  State<AccountDetailsPage> createState() => _AccountDetailsPageState();
}

class _AccountDetailsPageState extends State<AccountDetailsPage> {
  final _auth = FirebaseAuth.instance;

  String? _username;
  String? _email;
  String _passwordMask = '••••••••••••••••';

  @override
  void initState() {
    super.initState();
    final user = _auth.currentUser;
    _username = user?.displayName ?? 'Username';
    _email = user?.email ?? 'user@email.com';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.maybePop(context),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: Icon(Icons.more_vert),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Account Settings',
                style: AppTextStyles.h1
              ),
              EditableCard(
                value: _username ?? 'Username',
                onTap: () => _openEditSheet(
                  title: 'Username',
                  initial: _username ?? '',
                  onSave: (txt) async {
                    await _auth.currentUser?.updateDisplayName(txt);
                    setState(() => _username = txt);
                  },
                ),
              ),
              EditableCard(
                value: _email ?? 'user@email.com',
                onTap: () => _openEditSheet(
                  title: 'E-mail',
                  keyboardType: TextInputType.emailAddress,
                  initial: _email ?? '',
                  onSave: (txt) async {
                    // await _auth.currentUser?.updateEmail(txt);
                    setState(() => _email = txt);
                  },
                ),
              ),
              EditableCard(
                value: _passwordMask,
                obscureLikeMock: true,
                onTap: () => _openEditSheet(
                  title: 'Password',
                  isPassword: true,
                  initial: '',
                  onSave: (txt) async {
                    // await _auth.currentUser?.updatePassword(txt);
                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Senha atualizada.')),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openEditSheet({
    required String title,
    required String initial,
    required ValueChanged<String> onSave,
    TextInputType? keyboardType,
    bool isPassword = false,
  }) async {
    final controller = TextEditingController(text: initial);
    bool obscured = isPassword;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundWhiteLight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        final viewInsets = MediaQuery.of(context).viewInsets.bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, viewInsets + 16),
          child: Column(
            spacing: 10,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(title, style: AppTextStyles.h2),
              StatefulBuilder(
                builder: (context, setSB) {
                  return TextField(
                    controller: controller,
                    autofocus: true,
                    keyboardType: keyboardType,
                    obscureText: obscured,
                    decoration: InputDecoration(
                      hintText: title,
                      suffixIcon: isPassword
                          ? IconButton(
                        icon: Icon(
                          obscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () => setSB(() => obscured = !obscured),
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                },
              ),              
              FilledButton(
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isEmpty && !isPassword) return;
                  onSave(text);
                  Navigator.pop(context);
                },
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primaryDark,
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        );
      },
    );
  }
}
