import 'package:blindds_app/ui/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';

class IconsAppBar extends StatelessWidget {
  const IconsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          icon: Icons.lightbulb_outline,
          label: 'Sugestões',
          onPressed: () {
            // Lógica para Sugestões
          },
        ),
      ],
    );
  }
}
