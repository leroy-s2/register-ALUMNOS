import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/data/datasources/student_local_datasource.dart';
import 'src/data/repositories/student_repository_impl.dart';
import 'src/domain/usecases/save_student.dart';
import 'src/presentation/form/student_form_page.dart';
import 'src/presentation/providers/student_form_provider.dart';

void main() {
  // Simple manual DI for this exercise
  final local = InMemoryStudentLocalDataSource();
  final repo = StudentRepositoryImpl(local);
  final save = SaveStudentUseCase(repo);

  runApp(MyApp(saveStudentUseCase: save));
}

class MyApp extends StatelessWidget {
  final SaveStudentUseCase saveStudentUseCase;
  const MyApp({super.key, required this.saveStudentUseCase});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SaveStudentUseCase>.value(value: saveStudentUseCase),
        ChangeNotifierProvider(
          create: (_) => StudentFormProvider(saveStudentUseCase: saveStudentUseCase),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Registro de Estudiantes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const StudentFormPage(),
      ),
    );
  }
}
