import '../../domain/entities/student.dart';
import '../../domain/repositories/student_repository.dart';
import '../datasources/student_local_datasource.dart';

class StudentRepositoryImpl implements StudentRepository {
  final StudentLocalDataSource local;
  StudentRepositoryImpl(this.local);

  @override
  Future<List<Student>> getAllStudents() => local.getAll();

  @override
  Future<void> saveStudent(Student student) => local.save(student);
}
