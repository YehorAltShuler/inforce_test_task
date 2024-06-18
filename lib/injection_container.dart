import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:inforce_test_task/features/books/data/data_sources/books_remote_data_source.dart';

import 'features/books/data/repository/books_repository_impl.dart';
import 'features/books/domain/repository/books_repository.dart';
import 'features/books/domain/usecases/get_books.dart';
import 'features/books/presentation/bloc/books_bloc.dart';

final sl = GetIt.instance;

Future<void> initiallizedDependencies() async {
  // Dio
  sl
    ..registerSingleton<Dio>(Dio())

    // Data Sources
    ..registerSingleton<BooksRemoteDataSource>(BooksRemoteDataSource(sl()))

    // Repositories
    ..registerSingleton<BooksRepository>(BooksRepositoryImpl(sl()))

    //UseCases
    ..registerSingleton<GetBooks>(GetBooks(sl()))

    //Blocs
    ..registerFactory(() => (BooksBloc(sl())));
}
