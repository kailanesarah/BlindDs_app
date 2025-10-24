import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/widgets/appHeader/icons_app_bar.dart';
import 'package:blindds_app/ui/widgets/appHeader/user_profile_app_bar.dart';

/// Cabeçalho personalizado que combina o perfil do usuário (à esquerda)
/// e ícones de ação (à direita).
class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
    child: Container(
      height: 80,
      color: AppColors.bluePrimary ,
      padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        
        children: [
          /// Perfil do usuário (lado esquerdo)
          const UserProfileAppBar(
            backgroundImage: null,
            nameUser: 'Kailane',
          ),

          /// Ícones de ação (lado direito)
          const IconsAppBar(),
        ],
      ),
    ),
    );
  }

  /// Define a altura padrão para ser usada dentro de um Scaffold AppBar
  @override
  Size get preferredSize => const Size.fromHeight(80);
}
