import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/books/presentation/bloc/books_bloc.dart';
import 'features/books/presentation/pages/books_list_page.dart';
import 'injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initiallizedDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<BooksBloc>()..add(BooksGet()),
      child: MaterialApp(
        title: 'Infore Test Task',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        home: const BooksListPage(),
      ),
    );
  }
}
