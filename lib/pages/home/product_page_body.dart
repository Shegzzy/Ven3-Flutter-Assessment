import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

import '../../controllers/product_menu_controller.dart';
import '../../models/products_model.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_text_widget.dart';
import '../../widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.88);
  final _totalDots = 5;
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  @override
  void initState(){
    super.initState();
    Get.find<ProductMenuController>().getProductMenuList();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose(){
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Slider Section
        GetBuilder<ProductMenuController>(builder: (popularProducts){
          return popularProducts.isLoaded?SizedBox(
            height: Dimensions.pageView,

              child: PageView.builder(
                  controller: pageController,
                  itemCount: min(5, popularProducts.productMenuList.length),
                  itemBuilder: (context, position){
                    return _buildPageItem(position, popularProducts.productMenuList[position]);
                  }),

          ):
          CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //Dots
        GetBuilder<ProductMenuController>(builder: (popularProducts){
          return DotsIndicator(
            dotsCount: _totalDots,
            position: _currentPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.buttonBackgroundColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),

        SizedBox(height: Dimensions.height20,),

        //Product Heading
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "In Store"),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom: Dimensions.height10-5),
                child: BigText(text: ".", color: Colors.black26,),

              ),
              SizedBox(width: Dimensions.width10,),
              Container(
                margin: EdgeInsets.only(bottom:  Dimensions.height10-5),
                child: SmallText(text: "Food Pairing",),
              )
            ],
          ),
        ),


        //ProductList
        GetBuilder<ProductMenuController>(builder: (productMenu){
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: productMenu.productMenuList.length,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: (){
                    Get.toNamed(RouteHelper.getFoodMenu(index, "recommended food page"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.width30/2, right: Dimensions.width30/2, bottom: Dimensions.height20),
                    child: Row(
                      children: [
                        //Image container
                        Container(
                          width: Dimensions.listViewImgSize,
                          height: Dimensions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: Colors.white38,
                              boxShadow: const [
                                BoxShadow(
                                    color: Color(0xFFe8e8e8),
                                    blurRadius: 2.5,
                                    offset: Offset(0, 5)
                                )
                              ],
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "${productMenu.productMenuList[index].img!}"
                                  )
                              )

                          ),
                        ),

                        //Text container
                        Expanded(
                          child: Container(
                            height: Dimensions.listViewTextSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20),
                              color: AppColors.containerBackgroundColor,
                                boxShadow: [
                                  const BoxShadow(
                                      color: Color(0xFFe8e8e8),
                                      blurRadius: 0.5,
                                      offset: Offset(0, 5)
                                  ),
                                  BoxShadow(
                                      color: AppColors.containerBackgroundColor,
                                      offset: Offset(-5, 0)
                                  ),
                                  BoxShadow(
                                      color: AppColors.containerBackgroundColor,
                                      offset: Offset(5, 0)
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimensions.width15, right: Dimensions.width15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(
                                      text: productMenu.productMenuList[index].name!,
                                      size: Dimensions.font10+4,
                                  ),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.category_rounded, size: Dimensions.icon16,
                                          color: AppColors.iconColor2),
                                      SizedBox(width: Dimensions.font10-5),
                                      SmallText(text: productMenu.productMenuList[index].category, size: Dimensions.font10+2,),
                                    ],
                                  ),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(Icons.branding_watermark_rounded, size: Dimensions.icon16-4,
                                          color: AppColors.iconColor2),
                                      SizedBox(width: Dimensions.font10-5),
                                      SmallText(text: productMenu.productMenuList[index].brand, size: Dimensions.font10+1,),
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        )

                      ],
                    ),
                  ),
                );
              }

          );
        })

      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct){
    Matrix4 matrix = Matrix4.identity();
    if(index==_currentPageValue.floor()){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if(index == _currentPageValue.floor()+1){
      var currScale = _scaleFactor + (_currentPageValue - index+1)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else if(index == _currentPageValue.floor()-1){
      var currScale = 1 - (_currentPageValue-index)*(1-_scaleFactor);
      var currTrans = _height * (1-currScale)/2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(RouteHelper.getFoodMenu(index, "home"));
            },
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven?const Color(0xFF69c5df):const Color(0xFF9294cc),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xFFe8e8e8),
                        blurRadius: 2.5,
                        offset: Offset(0, 5)
                    )
                  ],
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          popularProduct.img!
                      )
                  )
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.containerBackgroundColor,
                boxShadow: [
                  const BoxShadow(
                    color: Color(0xFFe8e8e8),
                    blurRadius: 0.5,
                    offset: Offset(0, 5)
                  ),
                  BoxShadow(
                    color: AppColors.containerBackgroundColor,
                    offset: Offset(-5, 0)
                  ),
                  BoxShadow(
                    color: AppColors.containerBackgroundColor,
                    offset: Offset(5, 0)
                  )
                ]

              ),
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,top: Dimensions.height15, bottom: Dimensions.height10-2),
                child: AppColumn(text: popularProduct.name!)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
