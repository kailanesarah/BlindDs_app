import 'package:blindds_app/presentation/providers/classroom/student_classrooms_provider.dart';
import 'package:blindds_app/presentation/ui/dimens/app_dimensions.dart';
import 'package:blindds_app/presentation/ui/widgets/buttons/primary_fab_button.dart';
import 'package:blindds_app/presentation/ui/widgets/cards/classroom_details_card.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/centered_column_layout.dart';
import 'package:blindds_app/presentation/ui/widgets/layout/main_layout.dart';
import 'package:blindds_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassroomsScreen extends StatelessWidget {
  const ClassroomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.microtask(() {
      context.read<StudentClassroomsProvider>().loadClassrooms();
    });
    return Consumer<StudentClassroomsProvider>(
      builder: (context, provider, child) {
        final classrooms = provider.classrooms;

        return MainLayout(
          bodyContent: SingleChildScrollView(
            child: Semantics(
              container: true,
              label:
                  'Tela de lista de salas de aula. Aqui você pode visualizar todas as salas disponíveis e escolher uma para acessar.',
              child: CenteredColumn(
                children: [
                  const SizedBox(height: AppDimensions.spaceM),

                  if (provider.isLoading)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: CircularProgressIndicator(),
                    ),

                  if (!provider.isLoading && classrooms.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Nenhuma sala encontrada."),
                    ),

                  for (final classroom in classrooms) ...[
                    ClassroomDetailsCard(
                      className: classroom.name,
                      classDescription: classroom.description,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.classroomDetails,
                          arguments: classroom.id,
                        );
                      },
                    ),
                    const SizedBox(height: AppDimensions.spaceS),
                  ],

                  const SizedBox(height: AppDimensions.spaceS),
                ],
              ),
            ),
          ),

          // Floating Button
          floatingActionButton: PrimaryFabButton(
            semanticLabel: "Entrar em uma nova sala de aula",
            tooltip: "Entrar em uma nova sala de aula",
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.activityCode);
            },
          ),
        );
      },
    );
  }
}
