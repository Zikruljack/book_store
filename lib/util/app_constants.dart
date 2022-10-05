import 'package:book_store/data/model/response/language_model.dart';
import 'package:get/get.dart';

class AppConstant {
  static const String appName = 'Book Store';
  static const double appVersion = 1.0;

//URL ENDPOINT
  static const String baseUrl = 'http://localhost:3000/api';
  static const String loginUri = '/users/login';
  static const String registerUri = '/users/register/';
  static const String bookUri = '/books';
  static const String publisherUri = '/publishers';
  static const String authorUri = '/author';
  static const String categoryUri = '/categories';
  static const String categoryItem = '/categories/books';
  static const String searchUri = '/search';
  static const String tokenUri = '/token';
  static const String verifyTokenUri = '/tokenVerify';
  static const String configUri = '/configData';
  static const String categoryPublisher = '/category/publisher';
  static const String userInfo = '/users/user/';
  static const String userUpdateInfo = '/users/user/';
  static const String userDelete = '/users/';
  static const String wihsListGetUri = '';
  static const String wihsListAddUri = '';
  static const String wihsListRemoveUri = '';
  static const String runningOrderListUri = '';
  static const String historyOrderListUri = '';
  static const String orderDetailUri = '';
  static const String orderCancelUri = '';

  //SHARED KEY
  static const String token = 'bookStoreToken';
  static const String topic = 'bookstore';
  static const String localizationKey = 'X-localization';
  static const String userPassword = 'user_password';
  static const String userEmail = 'user_email';
  static const String userAddress = 'user_address';
  static const String cartList = 'cart_list';
  static const String languageCode = 'language_code';
  static const String countryCode = 'countryCode';
  static const String theme = 'theme';
  static const String searchHistory = 'searchHistory';
  static const String notification = 'notification';
  static const String intro = 'intro';
  static const String notificationCount = 'notificationCount';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en')
  ];
}

class Messages extends Translations {
  final Map<String, Map<String, String>> languages;
  Messages({required this.languages});

  @override
  Map<String, Map<String, String>> get keys {
    return languages;
  }
}
