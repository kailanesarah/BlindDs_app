import 'package:blindds_app/providers/auth/login_with_google_provider.dart';
import 'package:blindds_app/providers/login_buttons_provider.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/style/colors/app_colors.dart';
import 'package:blindds_app/ui/text/app_lexend_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.bluePrimary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _handleLoginGoogle(
    BuildContext context,
    LoginGoogleProvider provider,
    LoginButtonsProvider buttonsProvider,
  ) async {
    try {
      buttonsProvider.startGoogle();

      final success = await provider.loginUserWithGoogle();

      buttonsProvider.endGoogle(); 

      if (success && context.mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.activityCode);
      } else if (provider.errorMessage != null && context.mounted) {
        _showError(context, provider.errorMessage!);
      }
    } catch (e) {
      if (context.mounted) {
        _showError(context, 'Ocorreu um erro inesperado. Tente novamente.');
      }
      buttonsProvider.endGoogle(); // evita ficar travado
    }
  }

  @override
  Widget build(BuildContext context) {
    final googleProvider = context.watch<LoginGoogleProvider>();
    final buttons = context.watch<LoginButtonsProvider>();

    final isLoading = buttons.googleLoading;
    final isDisabled = buttons.disableAll;

    return Semantics(
      button: true,
      label: isLoading
          ? 'Entrando com o Google, aguarde'
          : 'Entrar com o Google',
      hint: isLoading
          ? 'O login está em andamento'
          : 'Pressione para fazer login com sua conta do Google',
      enabled: !isDisabled,
      child: FocusableActionDetector(
        enabled: !isDisabled,
        child: ElevatedButton(
          onPressed: isDisabled
              ? null
              : () => _handleLoginGoogle(context, googleProvider, buttons),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(
              AppDimensions.buttonWidth,
              AppDimensions.buttonHeight,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.spaceM,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            backgroundColor: AppColors.grayDisabled,
            foregroundColor: AppColors.grayBlackSecondary,
            elevation: 0,
          ),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isLoading)
                  const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.blueActive,
                      ),
                    ),
                  )
                else ...[
                  const FaIcon(FontAwesomeIcons.google),
                  const SizedBox(width: AppDimensions.iconL),
                  Text(
                    'Login com o Google',
                    style: SecondaryTextStyles.bodyBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
