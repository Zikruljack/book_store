class RegisterModel {
  String? fName;
  String? phone;
  String? email;
  String? password;

  RegisterModel({this.fName, this.phone, this.email, this.password});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    fName = json['f_name'];

    phone = json['phone'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['f_name'] = fName;
    data['phone'] = phone;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
