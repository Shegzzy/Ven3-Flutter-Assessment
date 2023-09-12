import 'package:get/get.dart';

import '../pages/Food/popular_food_details.dart';
import '../pages/Food/recommended_food_details.dart';
import '../pages/home/home_page.dart';
class RouteHelper{
  static const initial = "/";
  static const popularFood = "/popular-food";
  static const foodMenu = "/recommended-food";
  static const splashScreen = "/splash-screen";



  static String getPopularFood(int pageId, String page)=>'$popularFood?pageId=$pageId&page=$page';
  static String getFoodMenu(int pageId, String page)=>'$foodMenu?pageId=$pageId&page=$page';
  static String getSplashScreen()=> splashScreen;
  static String getInitial()=>initial;

  static List<GetPage> routes = [

    // GetPage(name: splashScreen, page: (){
    //   return const SplashScreen();
    // },
    //     transition: Transition.rightToLeftWithFade
    // ),

    GetPage(name: initial, page: (){
      return const HomePage();
    },
        transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return PopularFoodDetails(pageId:int.parse(pageId!), page:page!);
    },

      transition: Transition.rightToLeftWithFade
    ),

    GetPage(name: foodMenu, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters["page"];
      return RecommendedFoodDetails(pageId:int.parse(pageId!), page:page!);
    },
        transition: Transition.rightToLeftWithFade
    ),
  ];
}