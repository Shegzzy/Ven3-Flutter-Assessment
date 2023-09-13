import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repositories/product_menu_repo.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class ProductMenuController extends GetxController{
  final ProductMenuRepo productMenuRepo;
  ProductMenuController({required this.productMenuRepo});

  List<dynamic> _productMenuList=[];
  List<dynamic> get productMenuList => _productMenuList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getProductMenuList() async{
    Response response = await productMenuRepo.getProductMenuList();
    if(response.statusCode==200){
      _productMenuList=[];
      _productMenuList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      print("Products: $_productMenuList");
      update();
    }else{

    }
  }

  void setQuantity(bool isIncreament){
    if(isIncreament){
      _quantity = checkQuantity(_quantity + 1);
      //print("Quantity is $_quantity");
    }else{
      _quantity = checkQuantity(_quantity - 1);
      //print("Quantity is $_quantity");
    }
    update();
  }

  int checkQuantity(int quantity){
    if((_inCartItems + quantity) < 0){
      Get.snackbar("Item Count", "You can't reduce more!!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      if(_inCartItems>0){
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    }else if((_inCartItems + quantity) > 100){
      Get.snackbar("Item Count", "You can't add more!!",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
      );
      return 100;
    }else{
      return quantity;
    }
  }
}