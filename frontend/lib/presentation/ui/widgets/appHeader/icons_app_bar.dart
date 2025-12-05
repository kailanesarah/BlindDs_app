import 'package:blindds_app/presentation/providers/auth/login_provider.dart';
import 'package:blindds_app/presentation/providers/theme/theme_provider.dart';
import 'package:blindds_app/presentation/ui/widgets/buttons/custom_icon_button.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconsAppBar extends StatelessWidget {
  const IconsAppBar({super.key});

  void _handleDarkMode(ThemeProvider provider) {
    final isDark = provider.themeMode == ThemeMode.dark;
    provider.toggleTheme(!isDark);
  }

  Future<void> _handleLogout(
    AuthProvider authProvider,
    BuildContext context,
  ) async {
    final logoutSuccess = await authProvider.logout();

    if (logoutSuccess) {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, AuthProvider>(
      builder: (context, themeProvider, authProvider, _) {
        final isDark = themeProvider.themeMode == ThemeMode.dark;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconButton(
              icon: isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              label: isDark ? 'Tema claro' : 'Tema escuro',
              onPressed: () => _handleDarkMode(themeProvider),
            ),

            CustomIconButton(
              icon: Icons.logout,
              label: 'Dúvidas',
              onPressed: () => _handleLogout(authProvider, context),
            ),
          ],
        );
      },
    );
  }
}
