import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inforce_test_task/features/books/data/models/book_model.dart';

import '../../domain/entities/book.dart';
import '../bloc/books_bloc.dart';
import '../widgets/loader.dart';
import '../widgets/book_tile.dart';

class BooksListPage extends StatefulWidget {
  const BooksListPage({super.key});

  @override
  State<BooksListPage> createState() => _BooksListPageState();
}

class _BooksListPageState extends State<BooksListPage> {
  late TextEditingController controller;
  String _selectedSort = 'Alphabetically';

  @override
  void initState() {
    controller = TextEditingController()..text = '';
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _sortList() {
    setState(() {
      if (_selectedSort == 'Alphabetically') {
        context
            .read<BooksBloc>()
            .allBooks
            .sort((a, b) => a.title.compareTo(b.title));
      } else if (_selectedSort == 'By Count') {
        context
            .read<BooksBloc>()
            .allBooks
            .sort((a, b) => a.title.length.compareTo(b.title.length));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<BooksBloc, BooksState>(
        builder: (context, state) {
          if (state is BooksLoading || state is BooksInitial) {
            return const Loader();
          } else if (state is BooksError) {
            return Center(
              child: Text(state.error.toString()),
            );
          } else if (state is BooksGetSuccess) {
            final books = state.books;
            return _buildBooksList(books, context.read<BooksBloc>());
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: TextField(
        controller: controller,
        onSubmitted: (value) {
          if (value.isNotEmpty) {
            context
                .read<BooksBloc>()
                .allBooks
                .insert(0, BookModel(title: value));
            controller.clear();
            setState(() {});
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Please input book title'),
              ),
            );
          }
        },
      ),
      actions: [
        DropdownButton(
          value: _selectedSort,
          items: <String>['Alphabetically', 'By Count']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedSort = newValue!;
              _sortList();
            });
          },
        )
      ],
    );
  }

  Widget _buildBooksList(List<Book> books, BooksBloc bloc) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookTile(
          book: book,
          onDelete: () => setState(() {}),
        );
      },
    );
  }
}
