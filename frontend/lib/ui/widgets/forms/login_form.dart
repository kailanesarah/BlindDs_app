import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/buttons/google_login_button.dart';
import 'package:blindds_app/ui/widgets/text/text_divider.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryTextField(
          label: 'Email',
          hint: 'lana@gmail.com',
          controller: TextEditingController(),
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          onTap: null,
          prefixIcon: const Icon(Icons.email),
          readOnly: false,
          suffixIcon: null,
        ),

        const SizedBox(height: AppDimensions.spaceM),

        PrimaryTextField(
          label: 'Password',
          hint: 'senha123',
          controller: TextEditingController(),
          keyboardType: TextInputType.visiblePassword,
          obscureText: true,
          onTap: null,
          prefixIcon: const Icon(Icons.password),
          readOnly: false,
          suffixIcon: null,
        ),

        const SizedBox(height: AppDimensions.spaceL),
        PrimaryButton(
          text: "Entrar",
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.activityCode);
            // lógica do login aqui
          },
        ),

        const SizedBox(height: AppDimensions.spaceM),
        const TextDivider(),
        const SizedBox(height: AppDimensions.spaceM),

        GoogleSignInButton(onPressed: () => {}),
      ],
    );
  }
}
