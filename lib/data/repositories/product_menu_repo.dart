import 'package:get/get.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';

class ProductMenuRepo extends GetxService{
  final ApiClient apiClient;

  ProductMenuRepo({required this.apiClient});

  Future<Response> getProductMenuList() async{
    return await apiClient.getData(AppConstants.ALL_PRODUCT_URI);
  }
}