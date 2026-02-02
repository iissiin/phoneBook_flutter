import 'package:contactsapp/presentation/screens/contactsList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/contact_bloc.dart';
import 'bloc/contact_event.dart';
import 'data/repositories/contact_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ContactBloc(ContactRepository())..add(LoadContacts()),
      child: MaterialApp(
        title: 'Телефонная книга',
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        home: const ContactsListScreen(),
      ),
    );
  }
}
