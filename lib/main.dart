import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_store/controllers/product_menu_controller.dart';
import 'package:grocery_store/pages/home/home_page.dart';
import 'package:grocery_store/routes/route_helper.dart';
import 'helper/dependencies.dart' as dep;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductMenuController>(builder: (_){
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        // home: const HomePage(),
        initialRoute: RouteHelper.initial,
        getPages: RouteHelper.routes,
      );
    });
  }
}