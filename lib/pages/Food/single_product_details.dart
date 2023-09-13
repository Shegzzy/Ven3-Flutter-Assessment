import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/widgets/small_text.dart';
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
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: AppIcon(
                      size: Dimensions.icon24+4,
                      icon: Icons.clear_sharp,
                    backgroundColor: AppColors.containerBackgroundColor,
                  ),
                ),
                AppIcon(
                    icon: Icons.shopping_cart_outlined,
                    size: Dimensions.icon24+4,
                  backgroundColor: AppColors.containerBackgroundColor,
                )
              ],
            ),
            bottom: PreferredSize(preferredSize: const Size.fromHeight(20),
              child: Container(
                width: double.maxFinite,
                // padding: EdgeInsets.only(top: Dimensions.height10, bottom: Dimensions.height10-5),
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20+5),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius15),
                    topRight: Radius.circular(Dimensions.radius15),
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                            text: product.name!,
                            size: Dimensions.font18,

                        ),
                        SmallText(text: "${product.size!}, price")
                      ],
                    ),
                    Icon(
                      Icons.favorite_border_outlined,
                      color: AppColors.iconColor1,
                      size: Dimensions.icon24,
                    ),
                  ],
                ),
              ),
            ),
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                product.img,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20+5),
              child: Column(
                children: [
                  SizedBox(height: Dimensions.height20+10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: Dimensions.height15,
                               bottom: Dimensions.height20),
                          width: Dimensions.width45+120,
                          child: GetBuilder<ProductMenuController>(builder: (controller) {
                            return  Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    controller.setQuantity(false);
                                  },
                                  child: AppIcon(icon: Icons.remove, iconColor: AppColors.iconColor3, iconSize: Dimensions.icon24,),
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.width20, vertical: Dimensions.height10-5),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.borderColor
                                      ),
                                      borderRadius: BorderRadius.circular(Dimensions.radius15-5)
                                    ),
                                    child: BigText(text: "${controller.inCartItems}", size: Dimensions.font10+6,)),
                                GestureDetector(
                                  onTap: (){
                                    controller.setQuantity(true);
                                  },
                                  child: AppIcon(icon: Icons.add, iconColor: AppColors.iconColor2, iconSize: Dimensions.icon24,),
                                )
                              ],
                            );
                          })
                      ),
                      BigText(
                          text: "\$${product.price!}",
                          size: Dimensions.font10+6,
                      ),
                    ],
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height15,
                        bottom: Dimensions.height20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(text: "Product Details", size: Dimensions.font10+5,),
                        SizedBox(height: Dimensions.height10-5),
                        ExpandableText(
                            text: product.description!
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height15,
                        bottom: Dimensions.height20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(text: "Total In Stock", size: Dimensions.font10+5,),
                        ExpandableText(
                            text: product.quantity!.toString()
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductMenuController>(builder: (controller){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [

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
              child: Container(
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
            ),
          ],
        );
      }),
    );
  }
}
