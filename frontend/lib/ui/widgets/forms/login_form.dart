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

  Future<void> _handleLogin(
    BuildContext context,
    LoginProvider provider,
  ) async {
    final success = await provider.login(context);
    if (success && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.activityCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, provider, _) {
        return Semantics(
          container: true,
          label: 'Formulário de Login',
          hint: 'Informe seu email e senha para acessar a aplicação',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Campo de e-mail
              PrimaryTextField(
                label: 'Email',
                hint: 'exemplo@gmail.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) => provider.email = value,
                errorText: provider.emailError,
                prefixIcon: const Icon(Icons.email),
              ),
              const SizedBox(height: AppDimensions.spaceM),

              // Campo de senha
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
                    : () => _handleLogin(context, provider),
              ),

              const SizedBox(height: AppDimensions.spaceM),
              // Botão Google
              const GoogleSignInButton(),
            ],
          ),
        );
      },
    );
  }
}
