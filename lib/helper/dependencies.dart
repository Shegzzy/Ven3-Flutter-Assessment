import 'package:get/get.dart';
import '../controllers/product_menu_controller.dart';
import '../data/api/api_client.dart';
import '../data/repositories/product_menu_repo.dart';
import '../utils/app_constants.dart';

Future<void> init() async{

  //Api Client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //Product Repo
  Get.lazyPut(() => ProductMenuRepo(apiClient: Get.find()));

  //Product Controller
  Get.lazyPut(() => ProductMenuController(productMenuRepo: Get.find()));
}