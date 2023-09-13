import 'package:flutter/material.dart';
import 'package:grocery_store/utils/dimensions.dart';
import '../../utils/colors.dart';
import 'main_products_homepage.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List pages =[
    const MainFoodPage(),
    const Center(child: Text("History Page")),
    const Center(child: Text("Cart Page"),),
    const Center(child: Text("Profile Page"),),

  ];


  void onTapNav(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.iconColor1,
        unselectedItemColor: AppColors.iconColor2,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        selectedFontSize: 0.0,
        unselectedFontSize: 0.0,
        onTap: onTapNav,
        items: [
          BottomNavigationBarItem(
              icon: Icon( Icons.home_sharp, size: Dimensions.icon24-2,),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.history, size: Dimensions.icon24-2,),
              label: "history"
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.shopping_cart, size: Dimensions.icon24-2,),
              label: "cart"

          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.person_2_rounded, size: Dimensions.icon24-2,),
              label: "me"

          ),
        ],

      ),
    );
  }
}
