import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:inforce_test_task/features/books/data/data_sources/books_remote_data_source.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/book.dart';
import '../../domain/repository/books_repository.dart';

class BooksRepositoryImpl implements BooksRepository {
  final BooksRemoteDataSource _booksRemoteDataSource;

  BooksRepositoryImpl(this._booksRemoteDataSource);

  @override
  Future<Either<Failure, List<Book>>> getBooks({required int page}) async {
    try {
      final httpResponse = await _booksRemoteDataSource.fetchBooks();
      if (httpResponse.response.statusCode == 200) {
        final List<Book> books = httpResponse.data;
        return right(books);
      } else {
        return left(DataFailure(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
          ),
        ));
      }
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
