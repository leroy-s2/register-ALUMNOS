class Student {
  final String id;
  final String name;
  final String lastName;
  final String gender;
  final String email;
  final String phone;
  final String institution;
  final bool acceptedTerms;

  const Student({
    required this.id,
    required this.name,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phone,
    required this.institution,
    this.acceptedTerms = false,
  });

  Student copyWith({
    String? id,
    String? name,
    String? lastName,
    String? gender,
    String? email,
    String? phone,
    String? institution,
    bool? acceptedTerms,
  }) {
    return Student(
      id: id ?? this.id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      institution: institution ?? this.institution,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

  @override
  String toString() {
    return 'Student(id: $id, name: $name, lastName: $lastName, gender: $gender, email: $email, phone: $phone, institution: $institution, acceptedTerms: $acceptedTerms)';
  }
}
