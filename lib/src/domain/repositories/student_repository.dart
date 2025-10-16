import '../entities/student.dart';

abstract class StudentRepository {
  Future<void> saveStudent(Student student);
  Future<List<Student>> getAllStudents();
}
