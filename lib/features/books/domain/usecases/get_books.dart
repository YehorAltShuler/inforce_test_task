import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/book.dart';
import '../repository/books_repository.dart';

class GetBooks implements UseCase<List<Book>, NoParams> {
  final BooksRepository _booksRepository;

  GetBooks(this._booksRepository);

  @override
  Future<Either<Failure, List<Book>>> call(NoParams params) async {
    return await _booksRepository.getBooks(page: 1);
  }
}
