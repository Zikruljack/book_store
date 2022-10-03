import 'package:book_store/data/models/books_model.dart';

class AuthorModel {
  int? id;
  String? name;
  DateTime? dateOfBirth;
  String? city;
  String? image;
  List<BookModel>? bookId;

  AuthorModel(
      {this.id,
      this.name,
      this.dateOfBirth,
      this.city,
      this.image,
      this.bookId});

  AuthorModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dateOfBirth = json['dateOfBirth'];
    city = json['city'];
    image = json['image'];
    bookId = json['bookId'] != null
        ? (json['bookId'] as List).map((i) => BookModel.fromJson(i)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['dateOfBirth'] = dateOfBirth;
    data['city'] = city;
    data['image'] = image;
    data['bookId'] = bookId;
    return data;
  }
}
