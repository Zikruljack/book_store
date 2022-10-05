import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/model/response/book_model.dart';
import 'package:book_store/data/model/response/publisher_model.dart';
import 'package:book_store/data/repository/book_repo.dart';
import 'package:book_store/data/repository/wishlist_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class WishListController extends GetxController implements GetxService {
  final WishListRepo wishListRepo;
  final BookRepo itemRepo;
  WishListController({required this.wishListRepo, required this.itemRepo});

  late List<Book> _wishItemList;
  late List<Publisher> _wishPublisherList;
  List<int> _wishItemIdList = [];
  List<int> _wishPublisherIdList = [];

  List<Book> get wishItemList => _wishItemList;
  List<Publisher> get wishPublisherList => _wishPublisherList;
  List<int> get wishItemIdList => _wishItemIdList;
  List<int> get wishPublisherIdList => _wishPublisherIdList;

  void addToWishList(
      Book product, Publisher publisher, bool isPublisher) async {
    Response response = await wishListRepo.addWishList(
        isPublisher ? publisher.id! : product.id!, isPublisher);
    if (response.statusCode == 200) {
      if (isPublisher) {
        _wishPublisherIdList.add(publisher.id!);
        _wishPublisherList.add(publisher);
      } else {
        _wishItemList.add(product);
        _wishItemIdList.add(product.id!);
      }
      Fluttertoast.showToast(msg: response.body['message']);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void removeFromWishList(int id, bool isPublisher) async {
    Response response = await wishListRepo.removeWishList(id, isPublisher);
    if (response.statusCode == 200) {
      int idIndex = -1;
      if (isPublisher) {
        idIndex = _wishPublisherIdList.indexOf(id);
        _wishPublisherIdList.removeAt(idIndex);
        _wishPublisherList.removeAt(idIndex);
      } else {
        idIndex = _wishItemIdList.indexOf(id);
        _wishItemIdList.removeAt(idIndex);
        _wishItemList.removeAt(idIndex);
      }
      Fluttertoast.showToast(msg: response.body['message']);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> getWishList() async {
    _wishItemList = [];
    _wishPublisherList = [];
    _wishPublisherIdList = [];
    Response response = await wishListRepo.getWishList();
    if (response.statusCode == 200) {
      update();
      response.body['item'].forEach((items) async {
        Book item = Book.fromJson(items);
        _wishItemList.add(item);
        _wishItemIdList.add(item.id!);
      });
      // response.body['publisher'].forEach((publisher) async {
      //   Publisher publisher;
      //   try {
      //     publisher = Publisher.fromJson(store);
      //   } catch (e) {}

      //   _wishPublisherList.add(store);
      //   _wishPublisherIdList.add(store.id);
      // });
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  void removeWishes() {
    _wishItemIdList = [];
    _wishPublisherIdList = [];
  }
}
