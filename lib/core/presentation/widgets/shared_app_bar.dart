import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/theme_mode_controller.dart';
import '../../extensions/context_extensions.dart';

class SharedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onBack;

  const SharedAppBar({super.key, required this.onBack});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1.0); // +1 for bottom divider

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ThemeModeController>();
    final isDark = controller.isDark;

    return AppBar(
      backgroundColor: context.appColors.background,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          GestureDetector(
            onTap: onBack,
            child: Icon(
              Icons.arrow_back,
              color: context.appColors.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
      actions: [
        IconButton(
          onPressed: controller.toggleTheme,
          icon: Icon(
            isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            color: context.appColors.textSecondary,
          ),
          tooltip: isDark ? 'Switch to light mode' : 'Switch to dark mode',
        ),
      ],
    );
  }
}
