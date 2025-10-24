import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/buttons/switch_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PrimaryTextField(
          label: 'Nome',
          hint: 'Lana Magalhães',
          controller: TextEditingController(),
          keyboardType: TextInputType.name,
          obscureText: false,
          onTap: null,
          prefixIcon: const Icon(Icons.person),
          readOnly: false,
          suffixIcon: null,
        ),

        const SizedBox(height: AppDimensions.spaceM),

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

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Eu sou', style: SecondaryTextStyles.bodyBold),
            UserTypeSwitch(),
          ],
        ),

        const SizedBox(height: AppDimensions.spaceL),

        PrimaryButton(
          text: "Cadastre-se",
          onPressed: () {
            // lógica do registro aqui
          },
        ),
      ],
    );
  }
}
