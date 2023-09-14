import 'package:flutter/material.dart';
import 'package:grocery_store/routes/route_helper.dart';
import 'package:grocery_store/utils/dimensions.dart';
import 'package:grocery_store/widgets/big_text.dart';
import 'package:get/get.dart';
import '../../utils/colors.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> with TickerProviderStateMixin{
  late Animation<Offset> bottomAnimation;
  late AnimationController bottomAnimationController;

  @override
  void initState() {
    super.initState();

    // Animation from bottom
    bottomAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 6))..forward();
    bottomAnimation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: const Offset(0.0, 0.1),
    ).animate(CurvedAnimation(parent: bottomAnimationController, curve: Curves.linearToEaseOut));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
              image:AssetImage("assets/image/intro.jpg"),
          )
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: Dimensions.height45,
              child: SlideTransition(
                position: bottomAnimation,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Dimensions.width45),
                  width: Dimensions.screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: Dimensions.font18+20,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "To Our Store",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: Dimensions.font18+20,
                          ),
                        ),
                      ),
                      Text(
                        "Get your fresh groceries from our store",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: Dimensions.font10
                        ),
                      ),
                      SizedBox(height: Dimensions.height20,),
                      GestureDetector(
                        onTap: (){
                          Get.offNamed(RouteHelper.initial);
                        },
                        child: Container(
                          padding: EdgeInsets.only(left: Dimensions.width15,
                              right: Dimensions.width15,
                              top: Dimensions.height20-5,
                              bottom: Dimensions.height20-5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius15),
                            color: AppColors.buttonBackgroundColor,
                          ),
                          child: Center(
                              child: BigText(
                                text: "Get Started",
                                color: Colors.white,
                                size: Dimensions.font18-3,
                              )
                          ),
                        ),
                      ),
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
}
