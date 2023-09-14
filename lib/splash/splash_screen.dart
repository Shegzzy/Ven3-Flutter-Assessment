import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:grocery_store/widgets/small_text.dart';

import '../../controllers/product_menu_controller.dart';
import '../routes/route_helper.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late Animation<Offset> rightAnimation;
  late AnimationController rightAnimationController;

  late Animation<Offset> bottomAnimation;
  late AnimationController bottomAnimationController;

  Future<void> _loadResources() async {
    await Get.find<ProductMenuController>().getProductMenuList();
  }

  @override
  void initState() {
    _loadResources();
    super.initState();
    // Animation from left
    rightAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
    rightAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: rightAnimationController, curve: Curves.linearToEaseOut));

    // Animation from right
    bottomAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
    bottomAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: bottomAnimationController, curve: Curves.linearToEaseOut));

    Timer(
      const Duration(seconds: 7),
          () => Get.offNamed(RouteHelper.intro),
    );
  }

  @override
  void dispose() {
    rightAnimationController.dispose();
    bottomAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.buttonBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SlideTransition(
            position: rightAnimation,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/image/Group.svg", width: Dimensions.splashImg-85,),
                  SizedBox(width: Dimensions.width20,),
                  SvgPicture.asset("assets/image/logo.svg", width: Dimensions.splashImg,),
                ],
              ),
            ),
          ),
          SlideTransition(
            position: bottomAnimation,
            child: Center(
              child: SmallText(text: 'online grocery store', color: Colors.white, size: Dimensions.font10,)
            ),
          ),
        ],
      ),
    );
  }
}

