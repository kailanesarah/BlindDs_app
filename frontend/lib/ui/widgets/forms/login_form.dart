import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/buttons/google_login_button.dart';
import 'package:blindds_app/ui/widgets/text/text_divider.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, child) {
        return Semantics(
          container: true,
          label: 'Formulário de Login',
          hint: 'Informe seu email e senha para acessar a aplicação',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Email
              PrimaryTextField(
                label: 'Email',
                hint: 'exemplo@gmail.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => provider.email = value,
                errorText: provider.emailError,
                prefixIcon: const Icon(Icons.email),
              ),

              const SizedBox(height: AppDimensions.spaceM),

              // Senha
              PrimaryTextField(
                label: 'Senha',
                hint: '********',
                obscureText: true,
                onChanged: (value) => provider.password = value,
                errorText: provider.passwordError,
                prefixIcon: const Icon(Icons.password),
              ),

              const SizedBox(height: AppDimensions.spaceL),

              // Botão de login
              PrimaryButton(
                text: provider.isLoading ? 'Entrando...' : 'Entrar',
                onPressed: provider.isLoading
                    ? null
                    : () {
                        provider.login(context).then((success) {
                          if (success) {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.activityCode,
                            );
                          }
                        });
                      },
              ),

              const SizedBox(height: AppDimensions.spaceM),
              const TextDivider(),
              const SizedBox(height: AppDimensions.spaceM),

              GoogleSignInButton(
                onPressed: () {
                  // implementação do login social
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
