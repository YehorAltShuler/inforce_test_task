part of 'books_bloc.dart';

@immutable
sealed class BooksEvent {
  const BooksEvent();
}

final class BooksGet extends BooksEvent {}

final class BookAdd extends BooksEvent {
  final BookModel bookModel;

  const BookAdd({required this.bookModel});
}
