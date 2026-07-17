import 'package:flutter/material.dart';
import '../../../../shared/widgets/empty_state.dart';
import '../../../../core/theme/app_text_styles.dart';

class GlobalSearchScreen extends StatefulWidget {
  const GlobalSearchScreen({super.key});

  @override
  State<GlobalSearchScreen> createState() => _GlobalSearchScreenState();
}

class _GlobalSearchScreenState extends State<GlobalSearchScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  late final TabController _tabController;

  final List<String> _categories = const ['Repositories', 'Issues', 'Users', 'PRs', 'Files', 'Commits'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Search everything on GitHub', border: InputBorder.none),
          style: AppTextStyles.body(theme.colorScheme.onSurface),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _categories.map((category) => Tab(text: category)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _categories
            .map((category) => const EmptyState(icon: Icons.search, title: 'Start typing to search'))
            .toList(),
      ),
    );
  }
}
