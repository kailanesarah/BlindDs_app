import 'package:blindds_app/presentation/providers/classroom/classroom_provider.dart';
import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/classroom_details_card.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/activity_item_card.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassroomDetailsScreen extends StatelessWidget {
  const ClassroomDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Pega o ID da sala enviado via Navigator
    final classroomId = ModalRoute.of(context)!.settings.arguments as String;

    Future.microtask(() {
      context.read<ClassroomProvider>().getClassroom(classroomId);
    });

    return Consumer<ClassroomProvider>(
      builder: (context, provider, child) {
        final classroom = provider.classroom;

        return MainLayout(
          bodyContent: SingleChildScrollView(
            child: Semantics(
              container: true,
              label:
                  'Tela da sala de aula. Aqui são exibidas todas as atividades disponíveis para o aluno.',
              child: CenteredColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.spaceM),

                  if (provider.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),

                  if (!provider.isLoading && classroom == null)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Não foi possível carregar a sala."),
                    ),

                  // Conteúdo da sala
                  if (!provider.isLoading && classroom != null) ...[
                    ClassroomDetailsCard(
                      className: classroom.name,
                      classDescription: classroom.description,
                    ),
                    const SizedBox(height: AppDimensions.spaceM),
                    ActivityItemCard(
                      activityName: "teste",
                      activityDescription: "teste",
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.userMood);
                      },
                    ),
                    const SizedBox(height: AppDimensions.spaceS),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
