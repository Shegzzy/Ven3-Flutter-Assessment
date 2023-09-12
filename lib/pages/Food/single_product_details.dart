import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/product_menu_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text.dart';

class RecommendedFoodDetails extends StatelessWidget {
  final int pageId;
  final String page;
  const RecommendedFoodDetails({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<ProductMenuController>().productMenuList[pageId];
    // Get.find<PopularProductController>().initProduct(product, Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: Dimensions.height30+40,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    size: Dimensions.icon16,
                    icon: Icons.clear_sharp),
                AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    size: Dimensions.icon16,
                )
              ],
            ),
            bottom: PreferredSize(preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.height10-5, bottom: Dimensions.height10-5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius15),
                    topRight: Radius.circular(Dimensions.radius15),
                  )
                ),
                child: Center(
                  child: BigText(text: product.name!)
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.SINGLE_PRODUCT_URI+product.img,
                  width: double.maxFinite,
                  fit: BoxFit.cover,

              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                  child: ExpandableText(
                      text: product.description!
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductMenuController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width45+5,
                  right: Dimensions.width45+5,
                  top: Dimensions.height15,
                  bottom: Dimensions.height15
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove, iconColor: Colors.black54, backgroundColor: AppColors.mainColor),
                  ),
                  BigText(text: "\$${product.price!} X ${controller.inCartItems} "),
                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add, iconColor: Colors.black54, backgroundColor: AppColors.mainColor),
                  )
                ],
              ),
            ),
            Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
              decoration: BoxDecoration(
                  color: AppColors.buttonBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius30),
                    topRight: Radius.circular(Dimensions.radius30),

                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: Dimensions.height45-5,
                      height: Dimensions.height45-5,
                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10, top: Dimensions.height10, bottom: Dimensions.height10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius15),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.favorite_sharp,
                        color: AppColors.mainColor,
                        size: Dimensions.icon24,
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15, top: Dimensions.height10, bottom: Dimensions.height10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius15),
                      color: AppColors.mainColor,
                    ),
                    child: Row(
                      children: [
                        BigText(text: "\$${product.price!} Add to cart", color: Colors.white,),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
