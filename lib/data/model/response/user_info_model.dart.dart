class UserInfoModel {
  int? id;
  String? fName;
  String? email;
  String? image;
  String? phone;
  String? password;
  int? orderCount;

  UserInfoModel({
    this.id,
    this.fName,
    this.email,
    this.image,
    this.phone,
    this.password,
    this.orderCount,
  });

  UserInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    email = json['email'];
    image = json['image'];
    phone = json['phone'];
    password = json['password'];
    orderCount = json['order_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['f_name'] = fName;
    data['email'] = email;
    data['image'] = image;
    data['phone'] = phone;
    data['password'] = password;
    data['order_count'] = orderCount;

    return data;
  }
}
