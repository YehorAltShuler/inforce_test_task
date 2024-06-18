import 'dart:convert';

import 'package:inforce_test_task/features/books/domain/entities/book.dart';

class BookModel extends Book {
  BookModel({
    required super.title,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      title: map['title'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
