import 'package:book_store/data/models/books_model.dart';

class PublisherModel {
  int? id;
  String? name;
  List<BookModel>? bookId;

  PublisherModel({this.id, this.name, this.bookId});

  PublisherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    bookId = json['bookId'] != null
        ? (json['bookId'] as List).map((i) => BookModel.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['bookId'] = bookId;
    return data;
  }
}
