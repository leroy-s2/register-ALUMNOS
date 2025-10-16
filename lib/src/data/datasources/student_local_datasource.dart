import '../../domain/entities/student.dart';

abstract class StudentLocalDataSource {
  Future<void> save(Student student);
  Future<List<Student>> getAll();
}

class InMemoryStudentLocalDataSource implements StudentLocalDataSource {
  final List<Student> _items = [];

  @override
  Future<List<Student>> getAll() async {
    return List.unmodifiable(_items);
  }

  @override
  Future<void> save(Student student) async {
    _items.add(student);
    // Side-effect for this demo: print all items to console.
    // ignore: avoid_print
    print('========== LISTADO DE ESTUDIANTES ==========');
    for (var i = 0; i < _items.length; i++) {
      // ignore: avoid_print
      print('${i + 1}. ${_items[i]}');
    }
    // ignore: avoid_print
    print('============================================');
  }
}
