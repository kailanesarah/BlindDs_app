import 'package:blindds_app/providers/auth/login_with_google_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/colors/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: AppColors.bluePrimary),
    );
  }

  Future<void> _handleLoginGoogle(
    BuildContext context,
    LoginGoogleProvider provider,
  ) async {
    final success = await provider.loginWithGoogleAndDjango(context);

    if (success && context.mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.activityCode);
    } else if (provider.errorMessage != null) {
      _showError(context, provider.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginGoogleProvider>(
      builder: (context, loginProvider, child) {
        final isLoading = loginProvider.isLoading;

        return Semantics(
          button: true,
          label: isLoading
              ? 'Entrando com o Google, aguarde'
              : 'Entrar com o Google',
          hint: isLoading
              ? 'O login está em andamento'
              : 'Pressione para fazer login com sua conta do Google',
          enabled: !isLoading,
          child: FocusableActionDetector(
            focusNode: FocusNode(debugLabel: 'Botão de login com Google'),
            autofocus: false,
            enabled: !isLoading,
            child: SizedBox( 
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () => _handleLoginGoogle(context, loginProvider),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(
                    AppDimensions.buttonWidth,
                    AppDimensions.buttonHeight,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppDimensions.spaceM,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  backgroundColor: AppColors.grayDisabled,
                  foregroundColor: AppColors.grayBlackSecondary,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isLoading)
                        Semantics(
                          label: 'Carregando, por favor aguarde',
                          excludeSemantics: true,
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                AppColors.blueActive,
                              ),
                            ),
                          ),
                        )
                      else ...[
                        Semantics(
                          label: 'Ícone do Google',
                          excludeSemantics: true,
                          child: FaIcon(FontAwesomeIcons.google),
                        ),
                        SizedBox(width: AppDimensions.iconL),
                        Semantics(
                          label: 'Texto do botão de login com o Google',
                          excludeSemantics: true,
                          child: Text(
                            'Login com o Google',
                            style: SecondaryTextStyles.bodyBold,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
