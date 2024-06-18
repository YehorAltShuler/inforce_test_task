import 'package:dio/dio.dart';
import 'package:inforce_test_task/core/constants/app_constants.dart';
import 'package:retrofit/retrofit.dart';

import '../models/book_model.dart';

part 'books_remote_data_source.g.dart';

@RestApi(baseUrl: AppConstants.freeTestApiBaseUrl)
abstract class BooksRemoteDataSource {
  factory BooksRemoteDataSource(Dio dio, {String baseUrl}) =
      _BooksRemoteDataSource;

  @GET('/books')
  Future<HttpResponse<List<BookModel>>> fetchBooks();
}
