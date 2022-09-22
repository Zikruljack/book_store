class ShoppingCartModel {
  late int id;
  late String name;
  late String image;
  late double price;
  late int qty;

  ShoppingCartModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.qty});

  void setQty(int i) {
    if (i < 1) {
      qty = 1;
    } else {
      qty = i;
    }
  }
}

List<ShoppingCartModel> shoppingCartData = [
  ShoppingCartModel(
    id: 1,
    image: '',
    name: "abc",
    price: 123,
    qty: 1,
  ),
  ShoppingCartModel(
    id: 2,
    image: '',
    name: "abc",
    price: 123,
    qty: 1,
  ),
  ShoppingCartModel(
    id: 3,
    image: '',
    name: "abc",
    price: 123,
    qty: 1,
  ),
  ShoppingCartModel(
    id: 4,
    image: '',
    name: "abc",
    price: 123,
    qty: 1,
  ),
  ShoppingCartModel(
    id: 6,
    image: '',
    name: "abc",
    price: 123,
    qty: 1,
  ),
];
