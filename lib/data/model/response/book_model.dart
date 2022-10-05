class BookModel {
  int? totalSize;
  String? limit;
  int? offset;
  List<Book>? items;

  BookModel({this.totalSize, this.limit, this.offset, this.items});

  BookModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset =
        ((json['offset'] != null && json['offset'].toString().trim().isNotEmpty)
            ? int.parse(json['offset'].toString())
            : null)!;
    if (json['products'] != null) {
      items = [];
      json['products'].forEach((v) {
        items?.add(Book.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    data['products'] = items?.map((v) => v.toJson()).toList();
    return data;
  }
}

class Book {
  int? id;
  String? name;
  String? description;
  String? image;
  List<String>? images;
  int? categoryId;
  List<CategoryIds>? categoryIds;
  double? price;
  int? stock;

  Book({
    this.id,
    this.name,
    this.description,
    this.image,
    this.images,
    this.categoryId,
    this.categoryIds,
    this.price,
    this.stock,
  });

  Book.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    image = json['image'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    categoryId = json['category_id'];
    if (json['category_ids'] != null) {
      categoryIds = [];
      json['category_ids'].forEach((v) {
        categoryIds?.add(CategoryIds.fromJson(v));
      });

      price = json['price'].toDouble();
      stock = json['stock'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['image'] = image;
    data['images'] = images;
    data['category_id'] = categoryId;
    data['category_ids'] = categoryIds?.map((v) => v.toJson()).toList();

    data['price'] = price;

    data['stock'] = stock;

    return data;
  }
}

class CategoryIds {
  String? id;

  CategoryIds({this.id});

  CategoryIds.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
