import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inforce_test_task/features/books/presentation/bloc/books_bloc.dart';

import '../../domain/entities/book.dart';

class BookTile extends StatelessWidget {
  const BookTile({
    super.key,
    required this.book,
    required this.onDelete,
  });

  final Book book;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(book.title),
      trailing: IconButton(
        icon: const Icon(
          Icons.delete,
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Accept?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<BooksBloc>().allBooks.remove(book);
                      onDelete();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('No'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
