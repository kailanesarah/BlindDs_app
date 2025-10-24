import 'package:blindds_app/ui/widgets/buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';

class IconsAppBar extends StatelessWidget{

  const IconsAppBar({super.key});


  @override
  Widget build(BuildContext context) {
   return Row(
            mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
            children: [
              CustomIconButton(
                // CORREÇÃO DE ÍCONE: Use a classe Icons.
                icon: Icons.notifications_outlined, 
                onPressed: () {
                  // Lógica para Notificações
                },
              ),
              CustomIconButton(
                icon: Icons.help_outline, 
                onPressed: () {
                  // Lógica para Dúvidas
                },
              ),
              CustomIconButton(
                icon: Icons.lightbulb_outline, // Sugestão para Sugestões
                onPressed: () {
                  // Lógica para Sugestões
                },
              ),
            ],
          );
  }

}