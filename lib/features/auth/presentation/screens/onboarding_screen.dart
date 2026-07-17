import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class _OnboardingPageData {
  final IconData icon;
  final String title;
  final List<String> points;

  const _OnboardingPageData({required this.icon, required this.title, required this.points});
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _page = 0;

  final List<_OnboardingPageData> _pages = const [
    _OnboardingPageData(
      icon: Icons.hub_outlined,
      title: 'Manage GitHub from Anywhere',
      points: ['Review PRs', 'Track Issues', 'Stay Updated'],
    ),
    _OnboardingPageData(
      icon: Icons.auto_awesome_outlined,
      title: 'AI Code Review',
      points: ['Summaries', 'Review suggestions', 'Code explanation'],
    ),
    _OnboardingPageData(
      icon: Icons.notifications_active_outlined,
      title: 'Never Miss a Build',
      points: ['Notifications', 'CI Status', 'Releases', 'Daily Digest'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _page = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(page.icon, size: 96, color: AppColors.primary),
                        const SizedBox(height: 32),
                        Text(
                          page.title,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.heading1(theme.colorScheme.onSurface),
                        ),
                        const SizedBox(height: 24),
                        ...page.points.map(
                          (point) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.check_circle, color: AppColors.secondary, size: 18),
                                const SizedBox(width: 8),
                                Text(point, style: AppTextStyles.body(theme.colorScheme.onSurface)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _page == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _page == index ? AppColors.primary : AppColors.border,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.go('/login'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('Continue with GitHub', style: AppTextStyles.button(Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
