// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:autonoma_16/main.dart';
import 'package:autonoma_16/src/data/datasources/student_local_datasource.dart';
import 'package:autonoma_16/src/data/repositories/student_repository_impl.dart';
import 'package:autonoma_16/src/domain/usecases/save_student.dart';

void main() {
  testWidgets('Student form renders', (WidgetTester tester) async {
    final save = SaveStudentUseCase(
      StudentRepositoryImpl(InMemoryStudentLocalDataSource()),
    );

    await tester.pumpWidget(MyApp(saveStudentUseCase: save));
    await tester.pumpAndSettle();

    expect(find.text('Registro de Estudiantes'), findsOneWidget);
    expect(find.text('Registrarse'), findsOneWidget);
  });
}
