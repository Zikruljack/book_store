class CategoryAllProductModel {
  late int id;
  late String name;
  late double price;
  late String image;
  late int review;
  late int sale;

  CategoryAllProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.review,
    required this.sale,
  });

  CategoryAllProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'].toDouble();
    image = json['image'];
    review = json['review'];
    sale = json['sale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['image'] = image;
    data['review'] = review;
    data['sale'] = sale;
    return data;
  }
}
