import 'package:blindds_app/presentation/providers/classroom/student_classrooms_decision_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blindds_app/routes/app_routes.dart';

class StudentClassroomsDecisionScreen extends StatelessWidget {
  const StudentClassroomsDecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final decisionProvider = Provider.of<StudentClassroomsDecisionProvider>(
        context,
        listen: false,
      );

      if (decisionProvider.isLoading == false &&
          decisionProvider.hasClassrooms == null) {
        await decisionProvider.decide();

        if (!context.mounted) return;

        if (decisionProvider.hasClassrooms == true) {
          Navigator.pushReplacementNamed(context, AppRoutes.classroomsList);
        } else {
          Navigator.pushReplacementNamed(context, AppRoutes.login);
        }
      }
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
