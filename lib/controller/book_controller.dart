import 'package:book_store/controller/cart_controller.dart';
import 'package:book_store/controller/splash_controller.dart';
import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/model/response/book_model.dart';
import 'package:book_store/data/model/response/cart_model.dart';
import 'package:book_store/data/model/response/order_detail_model.dart';
import 'package:book_store/data/repository/book_repo.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class BookController extends GetxController implements GetxService {
  final BookRepo bookRepo;
  BookController({required this.bookRepo});

  // Latest products
  late List<Book> _popularItemList;
  late List<Book> _reviewedItemList;
  bool _isLoading = false;
  late List<int> _variationIndex;
  int _quantity = 1;
  final List<bool> _addOnActiveList = [];
  final List<int> _addOnQtyList = [];
  final String _popularType = 'all';
  final String _reviewedType = 'all';
  static final List<String> _itemTypeList = ['all', 'veg', 'non_veg'];
  int _imageIndex = 0;
  int _cartIndex = -1;
  late Book _item;
  int _productSelect = 0;
  int _imageSliderIndex = 0;

  List<Book> get popularItemList => _popularItemList;
  List<Book> get reviewedItemList => _reviewedItemList;
  bool get isLoading => _isLoading;
  List<int> get variationIndex => _variationIndex;
  int get quantity => _quantity;
  List<bool> get addOnActiveList => _addOnActiveList;
  List<int> get addOnQtyList => _addOnQtyList;
  String get popularType => _popularType;
  String get reviewType => _reviewedType;
  List<String> get itemTypeList => _itemTypeList;
  int get imageIndex => _imageIndex;
  int get cartIndex => _cartIndex;
  Book get item => _item;
  int get productSelect => _productSelect;
  int get imageSliderIndex => _imageSliderIndex;

  // Future<void> getPopularItemList(bool reload, String type, bool notify) async {
  //   _popularType = type;
  //   if (reload) {
  //     _popularItemList = null;
  //   }
  //   if (notify) {
  //     update();
  //   }
  //   if (reload) {
  //     Response response = await bookRepo.getPopularItemList(type);
  //     if (response.statusCode == 200) {
  //       _popularItemList = [];
  //       _popularItemList.addAll(ItemModel.fromJson(response.body).items);
  //       _isLoading = false;
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //     update();
  //   }
  // }

  // Future<void> getReviewedItemList(
  //     bool reload, String type, bool notify) async {
  //   _reviewedType = type;
  //   if (reload) {
  //     _reviewedItemList = null as List<Book>;
  //   }
  //   if (notify) {
  //     update();
  //   }
  //   if (reload) {
  //     Response response = await bookRepo.getReviewedItemList(type);
  //     if (response.statusCode == 200) {
  //       _reviewedItemList = [];
  //       _reviewedItemList
  //           .addAll(BookModel.fromJson(response.body).items!.toList());
  //       _isLoading = false;
  //     } else {
  //       ApiChecker.checkApi(response);
  //     }
  //     update();
  //   }
  // }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  void initData(Book item, CartModel cart) {
    if (cart != null) {
      _quantity = cart.quantity;
    } else {
      _quantity = 1;
      setExistInCart(item, notify: false);
    }
  }

  int setExistInCart(Book item, {bool notify = false}) {
    _cartIndex =
        Get.find<CartController>().isExistInCart(item.id!, false, null as int);
    if (_cartIndex != -1) {
      _quantity = Get.find<CartController>().cartList[_cartIndex].quantity;
    }
    if (notify) {
      update();
    }
    return _cartIndex;
  }

  void setAddOnQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _addOnQtyList[index] = _addOnQtyList[index] + 1;
    } else {
      _addOnQtyList[index] = _addOnQtyList[index] - 1;
    }
    update();
  }

  void setQuantity(bool isIncrement, int stock) {
    if (isIncrement) {
      if (Get.find<SplashController>().configModel.isStock! &&
          _quantity >= stock) {
        Fluttertoast.showToast(msg: 'out_of_stock'.tr);
      } else {
        _quantity = _quantity + 1;
      }
    } else {
      _quantity = _quantity - 1;
    }
    update();
  }

  void setCartVariationIndex(int index, int i, Book item) {
    _variationIndex[index] = i;
    _quantity = 1;
    setExistInCart(item);
    update();
  }

  void addAddOn(bool isAdd, int index) {
    _addOnActiveList[index] = isAdd;
    update();
  }

  List<bool> _loadingList = [];
  List<bool> _submitList = [];
  int _deliveryManRating = 0;

  List<bool> get loadingList => _loadingList;
  List<bool> get submitList => _submitList;
  int get deliveryManRating => _deliveryManRating;

  void initRatingData(List<OrderDetailsModel> orderDetailsList) {
    _loadingList = [];
    _submitList = [];
    _deliveryManRating = 0;
    for (var orderDetails in orderDetailsList) {
      _loadingList.add(false);
      _submitList.add(false);
    }
  }

  void setDeliveryManRating(int rate) {
    _deliveryManRating = rate;
    update();
  }

  // Future<ResponseModel> submitReview(int index, ReviewBody reviewBody) async {
  //   _loadingList[index] = true;
  //   update();

  //   Response response = await itemRepo.submitReview(reviewBody);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     _submitList[index] = true;
  //     responseModel = ResponseModel(true, 'Review submitted successfully');
  //     update();
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _loadingList[index] = false;
  //   update();
  //   return responseModel;
  // }

  // Future<ResponseModel> submitDeliveryManReview(ReviewBody reviewBody) async {
  //   _isLoading = true;
  //   update();
  //   Response response = await itemRepo.submitDeliveryManReview(reviewBody);
  //   ResponseModel responseModel;
  //   if (response.statusCode == 200) {
  //     _deliveryManRating = 0;
  //     responseModel = ResponseModel(true, 'Review submitted successfully');
  //     update();
  //   } else {
  //     responseModel = ResponseModel(false, response.statusText);
  //   }
  //   _isLoading = false;
  //   update();
  //   return responseModel;
  // }

  void setImageIndex(int index, bool notify) {
    _imageIndex = index;
    if (notify) {
      update();
    }
  }

  Future<void> getProductDetails(Book item) async {
    _item = null as Book;
    if (item.name != null) {
      _item = item;
    } else {
      _item = null as Book;
      Response response = await bookRepo.getItemDetails(item.id!);
      if (response.statusCode == 200) {
        _item = Book.fromJson(response.body);
      } else {
        ApiChecker.checkApi(response);
      }
    }
    initData(_item, null as CartModel);
    setExistInCart(item, notify: false);
  }

  void setSelect(int select, bool notify) {
    _productSelect = select;
    if (notify) {
      update();
    }
  }

  void setImageSliderIndex(int index) {
    _imageSliderIndex = index;
    update();
  }

  // double getStartingPrice(Book item) {
  //   double startingPrice = 0;
  //   if (item.choiceOptions.length != 0) {
  //     List<double> priceList = [];
  //     item.variations.forEach((variation) => priceList.add(variation.price));
  //     priceList.sort((a, b) => a.compareTo(b));
  //     startingPrice = priceList[0];
  //   } else {
  //     startingPrice = item.price;
  //   }
  //   return startingPrice;
  // }

  // bool isAvailable(Book item) {
  //   return DateConverter.isAvailable(
  //       item.availableTimeStarts, item.availableTimeEnds);
  // }

  // double getDiscount(Item item) =>
  //     item.storeDiscount == 0 ? item.discount : item.storeDiscount;

  // String getDiscountType(Item item) =>
  //     item.storeDiscount == 0 ? item.discountType : 'percent';

  // void navigateToItemPage(Book item, BuildContext context,
  //     {bool inStore = false, bool isCampaign = false}) {
  //   if (Get.find<SplashController>().configModel.isPublisher!) {
  //     ResponsiveHelper.isMobile(context)
  //         ? Get.bottomSheet(
  //             ItemBottomSheet(
  //                 item: item, inStorePage: inStore, isCampaign: isCampaign),
  //             backgroundColor: Colors.transparent,
  //             isScrollControlled: true,
  //           )
  //         : Get.dialog(
  //             Dialog(
  //                 child: ItemBottomSheet(
  //                     item: item,
  //                     inStorePage: inStore,
  //                     isCampaign: isCampaign)),
  //           );
  //   } else {
  //     Get.toNamed(RouteHelper.getItemDetailsRoute(item.id, inStore),
  //         arguments: ItemDetailsScreen(item: item, inStorePage: inStore));
  //   }
  // }
}
