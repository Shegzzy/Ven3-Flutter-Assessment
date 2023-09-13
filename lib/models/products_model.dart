class Product {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<ProductModel> _products;
  List<ProductModel> get products => _products;

  Product({required totalSize, required typeId, required offset, required products}){
    this._totalSize = totalSize;
    this._typeId = typeId;
    this._offset = offset;
    this._products = products;

  }

  Product.fromJson(List<dynamic> json) {
    _totalSize = json.length;
    print("Quantity $_totalSize");
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
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  ProductModel(
      {this.id,
        this.name,
        this.description,
        this.price,
        this.size,
        this.img,
        this.location,
        this.createdAt,
        this.updatedAt,
        this.typeId}
      );

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    size = json['size'];
    img = json['image'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson(){
    return {
      "id":this.id,
      "name":this.name,
      "price":this.price,
      "img":this.img,
      "location":this.location,
      "createdAt":this.createdAt,
      "updatedAt":this.updatedAt,
      "typeId":this.typeId,
    };
  }
}