import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/student_form_provider.dart';
import '../widgets/default_text.dart';
import '../../domain/usecases/save_student.dart';
import '../../data/repositories/student_repository_impl.dart';
import '../../data/datasources/student_local_datasource.dart';

class StudentFormPage extends StatelessWidget {
  const StudentFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Crear las dependencias necesarias
    final dataSource = InMemoryStudentLocalDataSource();
    final repository = StudentRepositoryImpl(dataSource);
    final saveStudentUseCase = SaveStudentUseCase(repository);

    return ChangeNotifierProvider(
      create: (_) => StudentFormProvider(saveStudentUseCase: saveStudentUseCase),
      builder: (context, _) {
        final provider = context.watch<StudentFormProvider>();

        return Scaffold(
          backgroundColor: Colors.grey.shade50,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              color: Colors.black87,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Form(
                key: provider.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 🧠 Encabezado
                    Center(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(Icons.school,
                                size: 48, color: Colors.blue.shade700),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Registro de Estudiantes',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completa tus datos para empezar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// 📌 Datos Personales
                    const Text(
                      'Datos Personales',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    DefaultTextField(
                      label: 'Nombre(s)',
                      hint: 'Ej: Juan',
                      icon: Icons.person_outline,
                      validator: provider.validateRequired,
                      onSaved: (v) => provider.name = v ?? '',
                    ),
                    const SizedBox(height: 12),

                    DefaultTextField(
                      label: 'Apellidos',
                      hint: 'Ej: Pérez Gómez',
                      icon: Icons.person_outline,
                      validator: provider.validateRequired,
                      onSaved: (v) => provider.lastName = v ?? '',
                    ),
                    const SizedBox(height: 12),

                     DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          labelText: 'Género',
                          prefixIcon: Icon(Icons.wc_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          filled: true,
                          fillColor: Colors.blueGrey.shade50,
                        ),
                        value: provider.gender.isEmpty ? null : provider.gender,
                        items: const [
                          DropdownMenuItem(value: 'MASCULINO', child: Text('Masculino')),
                          DropdownMenuItem(value: 'FEMENINO', child: Text('Femenino')),
                        ],
                        validator: provider.validateRequired,
                        onChanged: (v) => provider.gender = v ?? '',
                        onSaved: (v) => provider.gender = v ?? '',
                      ),

                     const SizedBox(height: 24),

                    /// ☎ Información de Contacto
                    const Text(
                      'Información de Contacto',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    DefaultTextField(
                      label: 'Correo Electrónico',
                      hint: 'Ej: tu.email@ejemplo.com',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: provider.validateEmail,
                      onSaved: (v) => provider.email = v ?? '',
                    ),
                    const SizedBox(height: 12),

                    DefaultTextField(
                      label: 'Número de Teléfono',
                      hint: 'Ej: +34 678 90 00 00',
                      icon: Icons.phone_outlined,
                      keyboardType: TextInputType.phone,
                      validator: provider.validateRequired,
                      onSaved: (v) => provider.phone = v ?? '',
                    ),

                    const SizedBox(height: 24),

                    /// 🎓 Información Académica
                    const Text(
                      'Información Académica',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),

                    DefaultTextField(
                      label: 'Institución Educativa',
                      hint: 'Ej: Universidad Central',
                      icon: Icons.school_outlined,
                      validator: provider.validateRequired,
                      onSaved: (v) => provider.institution = v ?? '',
                    ),

                    const SizedBox(height: 16),

                    /// ✅ Checkbox
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: provider.acceptedTerms,
                          onChanged: provider.toggleTerms,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade800,
                                ),
                                children: const [
                                  TextSpan(
                                      text:
                                          'Acepto los Términos y Condiciones y la '),
                                  TextSpan(
                                    text: 'Política de Privacidad',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    /// 🔘 Botón de Registro
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: provider.acceptedTerms
                            ? provider.onSubmit
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: Colors.blue,
                          disabledBackgroundColor: Colors.grey.shade300,
                        ),
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    /// 🔗 Iniciar Sesión
                    Center(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          children: [
                            TextSpan(text: '¿Ya tienes una cuenta? '),
                            TextSpan(
                              text: 'Iniciar Sesión',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
