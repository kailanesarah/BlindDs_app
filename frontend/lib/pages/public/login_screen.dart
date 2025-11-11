import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:blindds_app/ui/widgets/forms/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  'Tela de login. Informe seu e-mail e senha para acessar a sua conta.',
              child: CenteredColumn(
                children: [
                  Header(
                    title: "Bem-vindo de volta!",
                    subtitle:
                        "Acesse sua conta e comece a aprender estruturas de dados.",
                  ),
                  SizedBox(height: AppDimensions.spaceXL),
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
