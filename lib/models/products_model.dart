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
  String? brand;
  int? quantity;


  ProductModel({this.id,
    this.name,
    this.description,
    this.price,
    this.size,
    this.img,
    this.quantity,
    this.category,
    this.brand,
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
    brand = json['brand']['name'];

  }

  Map<String, dynamic> toJson(){
    return {
      "id":id,
      "name":name,
      "price":price,
      "image":img,
      "quantity":quantity,
      "category":category,
      "brand":brand
    };
  }
}
