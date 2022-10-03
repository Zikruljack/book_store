class CategoryModel {
  late int id;
  late String name;
  late String categoryImage;

  CategoryModel(
      {required this.id, required this.name, required this.categoryImage});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryImage: json['category_image'],
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryImage'] = categoryImage;
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
