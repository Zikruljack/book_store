class CategoryModel {
  late int id;
  late String name;
  late String image;

  CategoryModel({required this.id, required this.name, required this.image});
}

List<CategoryModel> categoryData = [
  CategoryModel(
    id: 1,
    name: "Comic/Manga",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 2,
    name: "Fiction",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 3,
    name: "Sci-Fi",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 4,
    name: "Edication",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 5,
    name: "Kids",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 6,
    name: "Biography",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 7,
    name: "Science",
    image: 'https://via.placeholder.com/150',
  ),
  CategoryModel(
    id: 8,
    name: "Megazine",
    image: 'https://via.placeholder.com/150',
  ),
];
