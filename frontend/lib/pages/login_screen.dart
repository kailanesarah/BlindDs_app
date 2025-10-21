import 'package:flutter/material.dart';

import 'package:blindds_app/ui/colors/colors_styles.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/text/atikson_text_styles.dart';
import 'package:blindds_app/ui/text/lexend_text_styles.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, 
        elevation: 0, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/public/images/banner.png',
              width: double.infinity, 
              height: 400, 
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
            
            const SizedBox(height: AppDimensions.spaceXL),

            Text(
              'Acesse sua conta',
              style: PrimaryTextStyles.h1Medium.copyWith(
                color: AppColors.grayBlackSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceS),

            Text(
              'Faça login para continuar ou cadastre-se para começar a usar o app.',
              style: SecondaryTextStyles.bodyRegular.copyWith(
                color: AppColors.grayBlackSecondary,
              ),
              textAlign: TextAlign.center,
            ),
             const SizedBox(height: AppDimensions.spaceXL),

            PrimaryButton(
              text: 'Login',
              onPressed: () {
        
              },
            ),
            const SizedBox(height: AppDimensions.spaceM),

            PrimaryButton(
              text: 'Cadastrar',
              onPressed: () {
        
              },
            ),
          ],
        ),
      ),
    );
  }
}
