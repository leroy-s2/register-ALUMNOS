import 'package:flutter_test/flutter_test.dart';
import 'package:autonoma_16/src/presentation/providers/student_form_provider.dart';
import 'package:autonoma_16/src/domain/usecases/save_student.dart';
import 'package:autonoma_16/src/data/datasources/student_local_datasource.dart';
import 'package:autonoma_16/src/data/repositories/student_repository_impl.dart';

void main() {
  test('Student form validations work', () async {
    final provider = StudentFormProvider(
      saveStudentUseCase: SaveStudentUseCase(
        StudentRepositoryImpl(InMemoryStudentLocalDataSource()),
      ),
    );

    expect(provider.validateName(''), isNotNull);
    expect(provider.validateName('Juan'), isNull);
    expect(provider.validateLastName(''), isNotNull);
    expect(provider.validateEmail('invalid'), isNotNull);
    expect(provider.validateEmail('test@example.com'), isNull);
    expect(provider.validatePhone('123'), isNotNull);
    expect(provider.validatePhone('12345678'), isNull);
  });
}
