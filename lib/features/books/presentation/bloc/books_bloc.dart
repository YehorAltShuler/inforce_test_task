import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inforce_test_task/features/books/data/models/book_model.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/book.dart';
import '../../domain/usecases/get_books.dart';
part 'books_event.dart';
part 'books_state.dart';

class BooksBloc extends Bloc<BooksEvent, BooksState> {
  final GetBooks _getBooks;
  List<Book> allBooks = [];

  BooksBloc(this._getBooks) : super(BooksInitial()) {
    on<BooksGet>(_onBooksGet);
  }

  void _onBooksGet(BooksGet event, Emitter<BooksState> emit) async {
    emit(BooksLoading());
    final response = await _getBooks(NoParams());
    response.fold((l) => emit(BooksError(l.message)), (r) {
      allBooks = r;
      allBooks.sort((a, b) => a.title.compareTo(b.title));
      emit(BooksGetSuccess(allBooks));
    });
  }
}
