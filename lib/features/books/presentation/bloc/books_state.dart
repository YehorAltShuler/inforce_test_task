part of 'books_bloc.dart';

@immutable
sealed class BooksState {
  const BooksState();
}

final class BooksInitial extends BooksState {}

final class BooksLoading extends BooksState {}

final class BooksGetSuccess extends BooksState {
  final List<Book> books;

  const BooksGetSuccess(this.books);
}

final class BooksError extends BooksState {
  final String error;

  const BooksError(this.error);
}
