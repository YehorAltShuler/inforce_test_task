import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../entities/book.dart';

abstract interface class BooksRepository {
  Future<Either<Failure, List<Book>>> getBooks({required int page});
}
