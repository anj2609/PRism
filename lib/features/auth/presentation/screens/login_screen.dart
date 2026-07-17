import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/auth_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _loading = false;

  final List<String> _permissions = const [
    'Repositories',
    'Pull Requests',
    'Issues',
    'Notifications',
  ];

  Future<void> _continueWithGithub() async {
    setState(() => _loading = true);
    await ref.read(authProvider.notifier).loginWithToken('placeholder_oauth_token');
    if (!mounted) return;
    context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.hub_outlined, size: 72, color: AppColors.primary),
              const SizedBox(height: 24),
              Text(
                'Continue with GitHub',
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2(theme.colorScheme.onSurface),
              ),
              const SizedBox(height: 32),
              Text('Why we need access?', style: AppTextStyles.bodyBold(theme.colorScheme.onSurface)),
              const SizedBox(height: 12),
              ..._permissions.map(
                (permission) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, color: AppColors.secondary, size: 18),
                      const SizedBox(width: 8),
                      Text(permission, style: AppTextStyles.body(theme.colorScheme.onSurface)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _loading ? null : _continueWithGithub,
                icon: _loading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Icon(Icons.code),
                label: Text(_loading ? 'Connecting...' : 'Continue with GitHub', style: AppTextStyles.button(Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
