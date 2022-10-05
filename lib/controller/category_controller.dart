import 'package:book_store/data/api/api_checker.dart';
import 'package:book_store/data/model/response/book_model.dart';
import 'package:book_store/data/model/response/category_model.dart';
import 'package:book_store/data/repository/category_repo.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  late List<CategoryModel> _categoryList;
  late List<CategoryModel> _subCategoryList;
  late List<Book> _categoryItemList;
  // List<Store> _categoryStoreList;
  List<Book> _searchItemList = [];
  // final List<Store> _searchStoreList = [];
  late List<bool> _interestSelectedList;
  bool _isLoading = false;
  late int _pageSize;
  late int _restPageSize;
  bool _isSearching = false;
  final int _subCategoryIndex = 0;
  String _type = 'all';
  final bool _isStore = false;
  String _searchText = '';
  final String _storeResultText = '';
  String _itemResultText = '';
  int _offset = 1;

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<Book> get categoryItemList => _categoryItemList;
  // List<Store> get categoryStoreList => _categoryStoreList;
  List<Book> get searchItemList => _searchItemList;
  // List<Store> get searchStoreList => _searchStoreList;
  List<bool> get interestSelectedList => _interestSelectedList;
  bool get isLoading => _isLoading;
  int get pageSize => _pageSize;
  int get restPageSize => _restPageSize;
  bool get isSearching => _isSearching;
  int get subCategoryIndex => _subCategoryIndex;
  String get type => _type;
  bool get isStore => _isStore;
  String get searchText => _searchText;
  int get offset => _offset;

  Future<void> getCategoryList(bool reload, {bool allCategory = false}) async {
    if (reload) {
      _categoryList;
      Response response = await categoryRepo.getCategoryList(allCategory);
      if (response.statusCode == 200) {
        _categoryList = [];
        _interestSelectedList = [];
        response.body.forEach((category) {
          _categoryList.add(CategoryModel.fromJson(category));
          _interestSelectedList.add(false);
        });
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  // void getSubCategoryList(String categoryID) async {
  //   _subCategoryIndex = 0;
  //   _subCategoryList;
  //   _categoryItemList;
  //   Response response = await categoryRepo.getSubCategoryList(categoryID);
  //   if (response.statusCode == 200) {
  //     _subCategoryList = [];
  //     _subCategoryList
  //         .add(CategoryModel(id: int.parse(categoryID), name: 'all'.tr));
  //     response.body.forEach(
  //         (category) => _subCategoryList.add(CategoryModel.fromJson(category)));
  //     getCategoryItemList(categoryID, 1, 'all', false);
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  // }

  // void setSubCategoryIndex(int index, String categoryID) {
  //   _subCategoryIndex = index;
  //   if (_isStore) {
  //     getCategoryStoreList(
  //         _subCategoryIndex == 0
  //             ? categoryID
  //             : _subCategoryList[index].id.toString(),
  //         1,
  //         _type,
  //         true);
  //   } else {
  //     getCategoryItemList(
  //         _subCategoryIndex == 0
  //             ? categoryID
  //             : _subCategoryList[index].id.toString(),
  //         1,
  //         _type,
  //         true);
  //   }
  // }

  void getCategoryItemList(
      String categoryID, int offset, String type, bool notify) async {
    _offset = offset;
    if (offset == 1) {
      if (_type == type) {
        _isSearching = false;
      }
      _type = type;
      if (notify) {
        update();
      }
      _categoryItemList;
    }
    Response response =
        await categoryRepo.getCategoryItemList(categoryID, offset, type);
    if (response.statusCode == 200) {
      if (offset == 1) {
        _categoryItemList = [];
      }
      _categoryItemList
          .addAll(BookModel.fromJson(response.body).items!.toList());
      _pageSize = BookModel.fromJson(response.body).totalSize!.toInt();
      _isLoading = false;
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }

  // void getCategoryStoreList(
  //     String categoryID, int offset, String type, bool notify) async {
  //   _offset = offset;
  //   if (offset == 1) {
  //     if (_type == type) {
  //       _isSearching = false;
  //     }
  //     _type = type;
  //     if (notify) {
  //       update();
  //     }
  //     _categoryStoreList ;
  //   }
  //   Response response =
  //       await categoryRepo.getCategoryStoreList(categoryID, offset, type);
  //   if (response.statusCode == 200) {
  //     if (offset == 1) {
  //       _categoryStoreList = [];
  //     }
  //     _categoryStoreList.addAll(StoreModel.fromJson(response.body).stores);
  //     _restPageSize = BookModel.fromJson(response.body).totalSize!;
  //     _isLoading = false;
  //   } else {
  //     ApiChecker.checkApi(response);
  //   }
  //   update();
  // }

  void searchData(String query, String categoryID, String type) async {
    if ((_isStore && query.isNotEmpty && query != _storeResultText) ||
        (!_isStore && query.isNotEmpty && query != _itemResultText)) {
      _searchText = query;
      _type = type;

      _searchItemList;

      _isSearching = true;
      update();

      Response response =
          await categoryRepo.getSearchData(query, categoryID, type);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _searchItemList = [];
        } else {
          _itemResultText = query;
          _searchItemList = [];
          _searchItemList
              .addAll(BookModel.fromJson(response.body).items!.toList());
        }
      } else {
        ApiChecker.checkApi(response);
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchItemList = [];
    _searchItemList.addAll(_categoryItemList);
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }
}
