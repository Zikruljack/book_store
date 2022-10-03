import 'dart:convert';

import 'package:book_store/data/models/cart_model.dart';

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String address;

  final String token;
  final List<ShoppingCartModel>? cart;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.address,
    required this.token,
    this.cart,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'address': address,
      'token': token,
      // 'cart': cart,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      address: map['address'] ?? '',
      token: map['token'] ?? '',
      cart: List<ShoppingCartModel>.from(
        map['cart']?.map(
              (x) => Map<String, dynamic>.from(x),
            ) ??
            [],
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? address,
    String? token,
    List<ShoppingCartModel<dynamic>>? cart,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      token: token ?? this.token,
      cart: cart ?? this.cart,
    );
  }
}
