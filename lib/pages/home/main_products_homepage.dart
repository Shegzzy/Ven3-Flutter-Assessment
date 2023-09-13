import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import '../../controllers/popular_product_controller.dart';
import '../../controllers/product_menu_controller.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import 'product_page_body.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

Future<void> _reLoadResources() async {
  await Get.find<ProductMenuController>().getProductMenuList();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(onRefresh: _reLoadResources, child: Column(
      children: [
        // Showing the header
        Container(
          margin: EdgeInsets.only(top: Dimensions.height45, bottom: Dimensions.height15),
          padding: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  BigText(text: "Lokoja", color: AppColors.iconColor1),
                  Row(
                    children: [
                      SmallText(text: "Kogi"),
                      Icon(Icons.arrow_drop_down_rounded, size: Dimensions.icon16,)
                    ],
                  )
                ],
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.all(Dimensions.width10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius15-5),
                    color: AppColors.iconColor2,
                  ),
                  child: Center(child: Icon(Icons.search, color:Colors.white, size: Dimensions.icon24,)),
                ),
              )
            ],
          ),
        ),
        // Showing the body
        const Expanded(
          child: SingleChildScrollView(
              child: FoodPageBody()
          ),),
      ],
    ));
  }
}
