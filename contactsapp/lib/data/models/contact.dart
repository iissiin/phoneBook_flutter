import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int? id;
  final String name;
  final String surname;
  final String phone;
  final String? email;
  final String? notes;
  final String? photo;

  const Contact({
    this.id,
    required this.name,
    required this.surname,
    required this.phone,
    this.email,
    this.notes,
    this.photo,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as int?,
      name: json['name'] as String,
      surname: json['surname'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String?,
      notes: json['notes'] as String?,
      photo: json['photo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'surname': surname,
      'phone': phone,
      'email': email ?? '',
      'notes': notes ?? '',
      'photo': photo ?? '',
    };
  }

  String get fullName => '$name $surname';

  @override
  List<Object?> get props => [id, name, surname, phone, email, notes, photo];
}
