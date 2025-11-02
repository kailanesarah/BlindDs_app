import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/images/login_banner.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: Semantics(
          container: true,
          label:
              'Tela de boas-vindas. O usuário pode optar por se cadastrar ou fazer login para acessar o aplicativo.',
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LoginBanner(),
              SizedBox(height: AppDimensions.spaceXL),
              Header(
                title: 'Bem vindo(a)!',
                subtitle:
                    'Dê o primeiro passo: cadastre-se ou faça login e comece a aprender hoje!',
              ),
              SizedBox(height: AppDimensions.spaceXL),
              PrimaryButton(
                text: 'Cadastre-se',
                onPressed: () => {
                  Navigator.pushNamed(context, AppRoutes.register),
                },
              ),
              SizedBox(height: AppDimensions.spaceM),
              PrimaryButton(
                text: 'Faça seu Login',
                backgroundColor: AppColors.grayDisabled,
                textColor: AppColors.bluePrimary,
                onPressed: () => {
                  Navigator.pushNamed(context, AppRoutes.login),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
