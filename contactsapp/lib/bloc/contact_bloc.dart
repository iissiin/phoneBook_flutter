import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repositories/contact_repository.dart';
import 'contact_event.dart';
import 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final ContactRepository repository;

  ContactBloc(this.repository) : super(ContactInitial()) {
    on<LoadContacts>(_onLoadContacts);
    on<AddContact>(_onAddContact);
    on<DeleteContact>(_onDeleteContact);
    on<UpdateContact>(_onUpdateContact);
  }

  Future<void> _onLoadContacts(
    LoadContacts event,
    Emitter<ContactState> emit,
  ) async {
    emit(ContactLoading());
    try {
      final contacts = await repository.getAllContacts();
      emit(ContactLoaded(contacts));
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onAddContact(
    AddContact event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await repository.createContact(event.contact);
      emit(const ContactOperationSuccess('Контакт успешно добавлен'));
      add(LoadContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onDeleteContact(
    DeleteContact event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await repository.deleteContact(event.id);
      emit(const ContactOperationSuccess('Контакт успешно удален'));
      add(LoadContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }

  Future<void> _onUpdateContact(
    UpdateContact event,
    Emitter<ContactState> emit,
  ) async {
    try {
      await repository.updateContact(event.contact);
      emit(const ContactOperationSuccess('Контакт успешно обновлен'));
      add(LoadContacts());
    } catch (e) {
      emit(ContactError(e.toString()));
    }
  }
}
