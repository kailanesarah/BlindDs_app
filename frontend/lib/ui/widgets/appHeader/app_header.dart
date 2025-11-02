import 'package:blindds_app/providers/session/load_session_provider.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/widgets/appHeader/icons_app_bar.dart';
import 'package:blindds_app/ui/widgets/appHeader/user_profile_app_bar.dart';
import 'package:provider/provider.dart';

class CustomAppHeader extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoadSessionProvider>(
      builder: (context, session, child) {
        if (!session.isLoaded) {
          return SafeArea(
            child: Container(
              height: 80,
              color: AppColors.bluePrimary,
              alignment: Alignment.center,
              child: const CircularProgressIndicator(color: Colors.white),
            ),
          );
        }

        final nameUser = session.username ?? 'Usuário';

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
