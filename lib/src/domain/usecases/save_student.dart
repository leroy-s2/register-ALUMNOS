import '../entities/student.dart';
import '../repositories/student_repository.dart';

class SaveStudentUseCase {
  final StudentRepository repository;
  SaveStudentUseCase(this.repository);

  Future<void> call(Student student) => repository.saveStudent(student);
}
