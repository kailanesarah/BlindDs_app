import 'package:blindds_app/providers/theme/theme_provider.dart';
import 'package:blindds_app/ui/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IconsAppBar extends StatelessWidget {
  const IconsAppBar({super.key});

  // Mude para receber o ThemeProvider
void _handleDarkMode(ThemeProvider provider) {
  // Acesso direto, não precisa mais do Provider.of(context)
  final isDark = provider.themeMode == ThemeMode.dark;
  provider.toggleTheme(!isDark);
}

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        final isDark = themeProvider.themeMode == ThemeMode.dark;

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconButton(
              icon: Icons.notifications_outlined,
              label: 'Notificações',
              onPressed: () {
                // Lógica para Notificações
              },
            ),
            CustomIconButton(
              icon: Icons.help_outline,
              label: 'Dúvidas',
              onPressed: () {
                // Lógica para Dúvidas
              },
            ),
            CustomIconButton(
              icon: isDark
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              label: isDark ? 'Tema claro' : 'Tema escuro',
              onPressed: () => _handleDarkMode(themeProvider),
            ),
          ],
        );
      },
    );
  }
}
