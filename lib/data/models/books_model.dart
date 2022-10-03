import 'package:book_store/data/models/author_model.dart';
import 'package:book_store/data/models/category_model.dart';
import 'package:book_store/data/models/publisher_model.dart';

class BookModel {
  int? id;
  String? title;
  String? synopsis;
  String? publicationYear;
  int? price;
  int? stock;
  AuthorModel? authorId;
  CategoryModel? categoryId;
  PublisherModel? publisherId;
  String? createAt;
  String? updateAt;

  BookModel(
      {this.id,
      this.title,
      this.synopsis,
      this.publicationYear,
      this.price,
      this.stock,
      this.authorId,
      this.categoryId,
      this.publisherId,
      this.createAt,
      this.updateAt});

  BookModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    synopsis = json['synopsis'];
    publicationYear = json['publicationYear'];
    price = json['price'];
    stock = json['stock'];
    authorId = json['authorId'];
    categoryId = json['categoryId'];
    publisherId = json['publisherId'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['synopsis'] = synopsis;
    data['publicationYear'] = publicationYear;
    data['price'] = price;
    data['stock'] = stock;
    data['authorId'] = authorId;
    data['categoryId'] = categoryId;
    data['publisherId'] = publisherId;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    return data;
  }
}
