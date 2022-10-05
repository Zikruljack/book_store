import 'package:book_store/data/model/response/language_model.dart';
import 'package:book_store/util/app_constants.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({required BuildContext context}) {
    return AppConstant.languages;
  }
}
