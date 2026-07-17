import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool _darkMode = false;
  bool _notifications = true;
  bool _aiSuggestions = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: _darkMode,
            onChanged: (value) => setState(() => _darkMode = value),
          ),
          SwitchListTile(
            title: const Text('Notifications'),
            value: _notifications,
            onChanged: (value) => setState(() => _notifications = value),
          ),
          SwitchListTile(
            title: const Text('AI Suggestions'),
            value: _aiSuggestions,
            onChanged: (value) => setState(() => _aiSuggestions = value),
          ),
          const ListTile(title: Text('GitHub Account'), subtitle: Text('@anj2609')),
          const ListTile(title: Text('Language'), subtitle: Text('English')),
          ListTile(
            title: const Text('Logout'),
            textColor: Colors.red,
            iconColor: Colors.red,
            leading: const Icon(Icons.logout),
            onTap: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/onboarding');
            },
          ),
        ],
      ),
    );
  }
}
