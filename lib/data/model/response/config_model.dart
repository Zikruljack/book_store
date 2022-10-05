class ConfigModel {
  int? appMinimumVersionAndroid;
  int? appMinimumVersionIos;
  bool? maintenanceMode;
  String? appUrlIos;
  String? appUrlAndroid;
  bool? isStock;
  String? timeFormat;
  bool? isPublisher;
  String? baseUrls;
  String? itemImageUrl;

  ConfigModel(
      {this.appMinimumVersionAndroid,
      this.appMinimumVersionIos,
      this.maintenanceMode,
      this.appUrlAndroid,
      this.appUrlIos,
      this.isStock,
      this.timeFormat,
      this.isPublisher,
      this.baseUrls,
      this.itemImageUrl});
}
