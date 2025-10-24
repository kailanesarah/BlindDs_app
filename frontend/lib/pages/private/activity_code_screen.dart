import 'package:blindds_app/routes/app_routes.dart';
import 'package:blindds_app/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/ui/widgets/buttons/primary_button.dart';
import 'package:blindds_app/ui/widgets/fields/primary_field.dart';
import 'package:blindds_app/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/ui/widgets/text/header.dart';
import 'package:flutter/widgets.dart';

class ActivityCodeScreen extends StatelessWidget {

  const ActivityCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(bodyContent: Center(
      child: CenteredColumn(
        children: [
          Header(
            title:'Bem vindo ao BlindDs!' , 
            subtitle: 'Insira o código da atividade fornecido pelo professor.' ,),
                  SizedBox(height: AppDimensions.spaceXL),
        PrimaryTextField(
          label: 'Código da Atividade',
          hint: 'Ex: yAoiuLp7',
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: AppDimensions.spaceM),

        PrimaryButton(text: 'Continue',onPressed:() {
          Navigator.pushNamed(context, AppRoutes.userMood);
        } ,)

        ],
      )

    ));
  }


  
}