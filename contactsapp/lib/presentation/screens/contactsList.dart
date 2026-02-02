import 'package:contactsapp/presentation/screens/createContactScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/contact_bloc.dart';
import '../../bloc/contact_state.dart';

class ContactsListScreen extends StatelessWidget {
  const ContactsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Телефонная книга'), elevation: 2),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          if (state is ContactLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ContactLoaded) {
            if (state.contacts.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.contacts, size: 80, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Нет контактов',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Всего контактов: ${state.contacts.length}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.contacts.length,
                    itemBuilder: (context, index) {
                      final contact = state.contacts[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(
                              '${contact.name[0]}${contact.surname[0]}'
                                  .toUpperCase(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(contact.fullName),
                          subtitle: Text(contact.phone),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          return const Center(child: Text('Загрузка...'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateContactScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
