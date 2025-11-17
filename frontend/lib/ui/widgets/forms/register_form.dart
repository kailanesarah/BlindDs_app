import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/buttons/selector_button.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  Future<void> _handleRegister(
    BuildContext context,
    RegisterProvider provider,
  ) async {
    final isValid = provider.validateFields();
    if (!isValid) return;

    final success = await provider.register(); 

    if (success && context.mounted) {
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PrimaryTextField(
              label: 'Nome',
              hint: 'Lana Leal',
              prefixIcon: const Icon(Icons.person),
              onChanged: (value) => provider.name = value,
              errorText: provider.nameError,
            ),

          SizedBox(height: AppDimensions.spaceM),
        
            PrimaryTextField(
              label: 'Email',
              hint: 'lana@gmail.com',
              prefixIcon: const Icon(Icons.email),
              onChanged: (value) => provider.email = value,
              errorText: provider.emailError,
            ),

            SizedBox(height: AppDimensions.spaceM),

            PrimaryTextField(
              label: 'Senha',
              hint: 'senha123',
              obscureText: true,
              prefixIcon: const Icon(Icons.password),
              onChanged: (value) => provider.password = value,
              errorText: provider.passwordError,
            ),

            SizedBox(height: AppDimensions.spaceM),

            _buildUserTypeSelector(provider),

            SizedBox(height: AppDimensions.spaceM),

            PrimaryButton(
              text: provider.isLoading ? 'Cadastrando...' : 'Cadastre-se',
              onPressed: provider.isLoading
                  ? null
                  : () => _handleRegister(context, provider),
            ),

            if (provider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildUserTypeSelector(RegisterProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Eu sou', style: SecondaryTextStyles.bodyBold),
        UserTypeSelector(
          initialValue: provider.userType,
          onChanged: provider.setUserType,
        ),
      ],
    );
  }
}
