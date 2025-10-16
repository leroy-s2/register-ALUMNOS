# Autonoma 16 – Registro de Estudiantes (Clean Architecture + Provider)

Proyecto Flutter con formulario de Registro de Estudiantes, validaciones completas y manejo de estado con Provider. Estructura modular basada en Clean Architecture (Domain/Data/Presentation).

## Estructura
- `lib/src/domain` – entidades (Student), repositorios y casos de uso
- `lib/src/data` – datasource local en memoria e implementación de repositorio
- `lib/src/presentation` – provider y UI del formulario de registro

## Ejecutar
1. Instala dependencias
```
flutter pub get
```
2. Corre la app
```
flutter run
```

## ¿Qué hace?
- Completa los campos del formulario de registro de estudiantes (nombre, apellidos, género, correo, teléfono, institución educativa).
- Acepta términos y condiciones.
- Se valida cada campo (correo, teléfono, campos requeridos).
- Se crea un `Student` y se envía al caso de uso `SaveStudentUseCase`.
- El `InMemoryStudentLocalDataSource` mantiene la lista en memoria y la imprime en la consola como listado acumulado.

## Archivos clave
- `lib/main.dart` – Inyección simple de dependencias y arranque.
- `lib/src/domain/entities/student.dart` – Entidad Estudiante.
- `lib/src/domain/repositories/student_repository.dart` – Contrato del repositorio.
- `lib/src/domain/usecases/save_student.dart` – Caso de uso Guardar.
- `lib/src/data/datasources/student_local_datasource.dart` – Fuente local en memoria con `print` del listado.
- `lib/src/data/repositories/student_repository_impl.dart` – Implementación del repositorio.
- `lib/src/presentation/providers/student_form_provider.dart` – Lógica de formulario con ChangeNotifier.
- `lib/src/presentation/form/student_form_page.dart` – Pantalla del formulario de registro.
- `lib/src/presentation/widgets/default_text.dart` – TextField reutilizable.

## Tests
```
flutter test
```
