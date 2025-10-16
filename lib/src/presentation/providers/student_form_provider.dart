import 'package:flutter/material.dart';
import '../../domain/entities/student.dart';
import '../../domain/usecases/save_student.dart';

class StudentFormProvider extends ChangeNotifier {
  void setBirthDate(DateTime? date) {
    birthDate = date;
    notifyListeners();
  }
  final SaveStudentUseCase saveStudentUseCase;
  StudentFormProvider({required this.saveStudentUseCase});

  // Form key
  final formKey = GlobalKey<FormState>();

  // Fields
  String name = '';
  String lastName = '';
  String gender = '';
  DateTime? birthDate;
  String email = '';
  String phone = '';
  String institution = '';
  String? validateBirthDate(DateTime? v) {
    if (v == null) return 'Fecha de nacimiento es requerida';
    return null;
  }

  bool isSaving = false;

  get validateRequired => null;

  String? _required(String? v, {String label = 'Campo'}) {
    if (v == null || v.trim().isEmpty) return '$label es requerido';
    return null;
  }

  String? validateName(String? v) => _required(v, label: 'Nombre');
  String? validateLastName(String? v) => _required(v, label: 'Apellidos');
  String? validateGender(String? v) => _required(v, label: 'Género');
  
  String? validateEmail(String? v) {
    if (_required(v, label: 'Correo Electrónico') != null) {
      return _required(v, label: 'Correo Electrónico');
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(v!)) return 'Correo inválido';
    return null;
  }

  String? validatePhone(String? v) {
    if (_required(v, label: 'Teléfono') != null) return _required(v, label: 'Teléfono');
    if (v!.length < 8) return 'Teléfono debe tener al menos 8 dígitos';
    return null;
  }

  String? validateInstitution(String? v) => _required(v, label: 'Institución Educativa');


  Future<void> onSubmit() async {
    final current = formKey.currentState;
    if (current == null) return;
    if (!current.validate()) return;
    
    
    current.save();

    isSaving = true;
    notifyListeners();

    final student = Student(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name.trim(),
      lastName: lastName.trim(),
      gender: gender.trim(),
      email: email.trim(),
      phone: phone.trim(),
      institution: institution.trim(),
      // birthDate: birthDate, // Descomenta si tu entidad Student lo soporta
    );

    await saveStudentUseCase(student);
    
    isSaving = false;
    notifyListeners();
  }
}
