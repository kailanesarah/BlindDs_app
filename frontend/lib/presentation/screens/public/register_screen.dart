import 'package:blindds_app/presentation/ui/widgets/forms/register_form.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/widgets/text/header.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppDimensions.spaceM),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Semantics(
              container: true,
              label:
                  'Tela de cadastro de usuário. Preencha nome, e-mail, senha e selecione seu tipo de usuário para criar a conta.',
              child: CenteredColumn(
                children: [
                  Header(
                    title: "Faça seu cadastro!",
                    subtitle:
                        "Cadastre-se e inicie seu aprendizado agora mesmo.",
                  ),
                  SizedBox(height: AppDimensions.spaceXL),
                  RegisterForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
