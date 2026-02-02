import 'package:equatable/equatable.dart';
import '../data/models/contact.dart';

abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class LoadContacts extends ContactEvent {}

class AddContact extends ContactEvent {
  final Contact contact;

  const AddContact(this.contact);

  @override
  List<Object> get props => [contact];
}

class DeleteContact extends ContactEvent {
  final int id;

  const DeleteContact(this.id);

  @override
  List<Object> get props => [id];
}

class UpdateContact extends ContactEvent {
  final Contact contact;

  const UpdateContact(this.contact);

  @override
  List<Object> get props => [contact];
}
