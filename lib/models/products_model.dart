class Product {
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({required products}){
    _products = products;

  }

  Product.fromJson(List<dynamic> json) {
    _products = <ProductModel>[];
    json.forEach((v) {
      _products.add(ProductModel.fromJson(v));
    });
  }


}
class ProductModel {
  String? id;
  String? name;
  String? description;
  String? price;
  String? size;
  String? img;
  String? category;
  int? quantity;


  ProductModel({this.id,
    this.name,
    this.description,
    this.price,
    this.size,
    this.img,
    this.quantity,
    this.category,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    size = json['size'];
    img = json['image'];
    quantity = json['quantity'];
    category = json['category']['name'];

  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "quantity":this.quantity,
    };
  }
}

class ProductCategoryModel {
  String? id;
  String? name;


  ProductCategoryModel({this.id,
    this.name,
  });

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
    };
  }
}