import 'package:dio/dio.dart';
import '../models/contact.dart';

class ContactRepository {
  final Dio _dio;
  static const String baseUrl =
      'https://7c00de037cf3efbd.mokky.dev'; // Замените на ваш URL

  ContactRepository()
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {'Content-Type': 'application/json'},
        ),
      );

  Future<List<Contact>> getAllContacts() async {
    try {
      final response = await _dio.get('/contacts');
      final List<dynamic> data = response.data;
      return data.map((json) => Contact.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Ошибка загрузки контактов: $e');
    }
  }

  Future<Contact> createContact(Contact contact) async {
    try {
      final response = await _dio.post('/contacts', data: contact.toJson());
      return Contact.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка создания контакта: $e');
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      await _dio.delete('/contacts/$id');
    } catch (e) {
      throw Exception('Ошибка удаления контакта: $e');
    }
  }

  Future<Contact> updateContact(Contact contact) async {
    try {
      final response = await _dio.patch(
        '/contacts/${contact.id}',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data);
    } catch (e) {
      throw Exception('Ошибка обновления контакта: $e');
    }
  }
}
