import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/providers/auth/login_provider.dart';
import 'package:blindds_app/providers/login_buttons_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/buttons/google_login_button.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  Future<void> _handleLogin(
    BuildContext context,
    LoginProvider authProvider,
    LoginButtonsProvider buttonsProvider,
  ) async {
    buttonsProvider.startLogin();

    final success = await authProvider.loginUser();

    buttonsProvider.endLogin();

    if (success && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.activityCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonsProv = context.watch<LoginButtonsProvider>();

    return Consumer<LoginProvider>(
      builder: (context, authProvider, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryTextField(
              label: 'Email',
              hint: 'exemplo@gmail.com',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => authProvider.email = value,
              errorText: authProvider.errorMessage,
              prefixIcon: const Icon(Icons.email),
            ),

            const SizedBox(height: AppDimensions.spaceM),

            PrimaryTextField(
              label: 'Senha',
              hint: '********',
              obscureText: true,
              onChanged: (value) => authProvider.password = value,
              errorText: authProvider.errorMessage,
              prefixIcon: const Icon(Icons.password),
            ),

            const SizedBox(height: AppDimensions.spaceL),

            PrimaryButton(
              text: buttonsProv.loginLoading ? "Entrando..." : "Entrar",
              onPressed: buttonsProv.disableAll
                  ? null
                  : () => _handleLogin(context, authProvider, buttonsProv),
            ),

            const SizedBox(height: AppDimensions.spaceM),

            GoogleSignInButton(),
          ],
        );
      },
    );
  }
}
