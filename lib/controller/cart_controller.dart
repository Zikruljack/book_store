import 'package:book_store/controller/book_controller.dart';
import 'package:book_store/controller/splash_controller.dart';
import 'package:book_store/data/model/response/cart_model.dart';
import 'package:book_store/data/repository/cart_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  CartController({required this.cartRepo});

  List<CartModel> _cartList = [];

  List<CartModel> get cartList => _cartList;

  void getCartData() {
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
  }

  void addToCart(CartModel cartModel, int index) {
    if (index != -1) {
      _cartList.replaceRange(index, index + 1, [cartModel]);
    } else {
      _cartList.add(cartModel);
    }
    Get.find<BookController>().setExistInCart(cartModel.item, notify: true);
    cartRepo.addToCartList(_cartList);
    update();
  }

  void setQuantity(bool isIncrement, int cartIndex, int stock) {
    if (isIncrement) {
      if (Get.find<SplashController>().configModel.isStock! &&
          cartList[cartIndex].quantity >= stock) {
        Fluttertoast.showToast(msg: 'out_of_stock'.tr);
      } else {
        _cartList[cartIndex].quantity = _cartList[cartIndex].quantity + 1;
      }
    } else {
      _cartList[cartIndex].quantity = _cartList[cartIndex].quantity - 1;
    }
    cartRepo.addToCartList(_cartList);

    update();
  }

  void removeFromCart(int index) {
    _cartList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    if (Get.find<BookController>().item != null) {
      Get.find<BookController>()
          .setExistInCart(Get.find<BookController>().item, notify: true);
    }
    update();
  }

  // void removeAddOn(int index, int addOnIndex) {
  //   _cartList[index].addOnIds.removeAt(addOnIndex);
  //   cartRepo.addToCartList(_cartList);
  //   update();
  // }

  void clearCartList() {
    _cartList = [];
    cartRepo.addToCartList(_cartList);
    update();
  }

  int isExistInCart(int itemID, bool isUpdate, int cartIndex) {
    for (int index = 0; index < _cartList.length; index++) {
      if (_cartList[index].item.id == itemID) {
        if ((isUpdate && index == cartIndex)) {
          return -1;
        } else {
          return index;
        }
      }
    }
    return -1;
  }

  // bool existAnotherStoreItem(int storeID) {
  //   for (CartModel cartModel in _cartList) {
  //     if (cartModel.item.storeId != storeID) {
  //       return true;
  //     }
  //   }
  //   return false;
  // }

  void removeAllAndAddToCart(CartModel cartModel) {
    _cartList = [];
    _cartList.add(cartModel);
    Get.find<BookController>().setExistInCart(cartModel.item, notify: true);
    cartRepo.addToCartList(_cartList);
    update();
  }
}
