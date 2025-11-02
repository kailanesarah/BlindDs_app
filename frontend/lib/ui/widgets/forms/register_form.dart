import 'package:blindds_app/providers/auth/register_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/buttons/selector_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, provider, child) {
        return Semantics(
          container: true,
          label: 'Formulário de cadastro',
          hint:
              'Preencha nome, e-mail, senha e selecione se você é aluno ou professor',
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PrimaryTextField(
                label: 'Nome',
                hint: 'Lana Leal',
                keyboardType: TextInputType.name,
                obscureText: false,
                prefixIcon: Icon(Icons.person),
                onChanged: (value) => provider.name = value,
                errorText: provider.nameError,
              ),

              const SizedBox(height: AppDimensions.spaceM),

              PrimaryTextField(
                label: 'Email',
                hint: 'lana@gmail.com',
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                prefixIcon: const Icon(Icons.email),
                onChanged: (value) => provider.email = value,
                errorText: provider.emailError,
              ),

              const SizedBox(height: AppDimensions.spaceM),

              PrimaryTextField(
                label: 'Senha',
                hint: 'senha123',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                prefixIcon: Icon(Icons.password),
                onChanged: (value) => provider.password = value,
                errorText: provider.passwordError,
              ),

              const SizedBox(height: AppDimensions.spaceL),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Eu sou', style: SecondaryTextStyles.bodyBold),
                  UserTypeSelector(
                    initialValue: provider.userType,
                    onChanged: (value) => provider.setUserType(value),
                  ),
                ],
              ),

              const SizedBox(height: AppDimensions.spaceL),

              PrimaryButton(
                text: provider.isLoading ? 'Cadastrando...' : 'Cadastre-se',
                onPressed: provider.isLoading
                    ? null
                    : () {
                        provider.validateFields().then((valid) {
                          if (!valid) return;
                          provider.register().then((success) {
                            if (success && context.mounted) {
                              Navigator.pushNamed(context, AppRoutes.login);
                            }
                          });
                        });
                      },
              ),

              // Mensagem de erro
              if (provider.errorMessage != null) ...[
                const SizedBox(height: AppDimensions.spaceM),
                Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
