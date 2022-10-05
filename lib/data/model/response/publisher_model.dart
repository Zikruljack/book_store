class PublisherModel {
  int? totalSize;
  String? limit;
  int? offset;
  List<Publisher>? stores;

  PublisherModel({this.totalSize, this.limit, this.offset, this.stores});

  PublisherModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'].toString();
    offset =
        (json['offset'] != null && json['offset'].toString().trim().isNotEmpty)
            ? int.parse(json['offset'].toString())
            : null;
    if (json['stores'] != null) {
      stores = [];
      json['stores'].forEach((v) {
        stores!.add(Publisher.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Publisher {
  int? id;
  String? name;

  Publisher({
    this.id,
    this.name,
  });

  Publisher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;

    return data;
  }

  fromJson(json) {}
}
