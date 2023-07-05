class NewModel {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  NewModel({this.products, this.total, this.skip, this.limit});

  NewModel.fromjson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];

    limit = json['limit'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['skip'] = skip;

    data['limit'] = limit;
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  double? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  Products(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.discountPercentage,
      this.rating,
      this.stock,
      this.brand,
      this.category,
      this.thumbnail,
      this.images});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? '';
    description = json['description'] ?? '';
    price = json['price'] ?? 0;
    discountPercentage = json['discountPercentage'] ?? 0;
    rating = double.parse(json['rating'].toString());
    stock = json['stock'] ?? 0;
    brand = json['brand'] ?? '';
    category = json['category'] ?? '';
    thumbnail = json['thumbnail'] ?? '';
    images = json['images'].cast<String>();
  }

 
 
  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['discountPercentage'] = discountPercentage;
    data['rating'] = rating;
    data['stock'] = stock;
    data['brand'] = brand;
    data['category'] = category;
    data['thumbnail'] = thumbnail;
    data['images'] = images;
    return data;
  }
}
