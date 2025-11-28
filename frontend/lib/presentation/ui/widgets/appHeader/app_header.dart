import 'package:blindds_app/presentation/providers/auth/login_provider.dart';
import 'package:blindds_app/presentation/ui/style/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/presentation/ui/widgets/appHeader/icons_app_bar.dart';
import 'package:blindds_app/presentation/ui/widgets/appHeader/user_profile_app_bar.dart';
import 'package:provider/provider.dart';

class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        // LOADING
        if (auth.isLoading) {
          return SafeArea(
            child: Container(
              height: 80,
              color: AppColors.bluePrimary,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        // NOME DO USUÁRIO
        final nameUser = auth.currentUser?.username ?? "Carregando...";

        return SafeArea(
          child: Container(
            height: 80,
            color: AppColors.bluePrimary,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 10.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UserProfileAppBar(backgroundImage: null, nameUser: nameUser),
                const IconsAppBar(),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
