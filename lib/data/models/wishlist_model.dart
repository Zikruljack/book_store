import 'package:book_store/data/models/user_model.dart';

class WishlistModel {
  late int id;
  late String name;
  late double price;
  late String image;
  late int sale;
  late int stock;
  late User userId;

  WishlistModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.sale,
    required this.stock,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'sale': sale,
      'stock': stock,
      'userId': userId
    };
  }
}
