import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:movies_app/Constants/styles.dart';
import 'package:movies_app/Controllers/home_screen_controller.dart';
import 'package:movies_app/Controllers/search_screen_controller.dart';
import 'package:movies_app/Views/favourite_screen.dart';
import 'package:movies_app/Views/explore_screen.dart';
import 'package:movies_app/Views/search_screen.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final HomeScreenController homeScreenController =
      Get.put(HomeScreenController(), permanent: true);

  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: GetBuilder(
        init: homeScreenController,
        builder: (controller) {
          return Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.pageController,
                children: <Widget>[
                  ExploreScreen(),
                  FavouriteScreen(),
                  SearchScreen(),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.025),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(height * width * 0.0002),
                    ),
                    child: Container(
                      height: height * 0.065,
                      width: width * 0.6,
                      decoration: BoxDecoration(
                          color: MyColors.Blue,
                          borderRadius:
                              BorderRadius.circular(height * width * 0.00016)),
                      child: GNav(
                        selectedIndex: controller.pageIndex,
                        onTabChange: (value) {
                          if (value != 2) {
                            SearchScreenController searchScreenController =
                                Get.find();
                            searchScreenController.isFolded = true;
                            searchScreenController.searchController.text = "";
                            searchScreenController.filteredMovies.clear();
                          }
                          controller.pageController?.animateToPage(value,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        },
                        tabBorderRadius: height * width * 0.00016,
                        backgroundColor: MyColors.Blue,
                        color: Colors.white,
                        activeColor: Colors.white,
                        tabBackgroundColor: Colors.white10,
                        tabMargin: EdgeInsets.symmetric(
                            horizontal: width * 0.01,
                            vertical: height * 0.0049),
                        gap: width * 0.0130,
                        iconSize: height * width * 0.000074,
                        padding: EdgeInsets.all(width * height * 0.00004),
                        style: GnavStyle.google,
                        textStyle: MyStyles.myFontStyle.copyWith(
                          fontSize: width * height * 0.000048,
                        ),
                        tabs: const [
                          GButton(
                            icon: Icons.home,
                            text: 'Home',
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                          GButton(
                            icon: Icons.favorite_outline,
                            text: 'Favourite',
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                          GButton(
                            icon: Icons.search,
                            text: 'Search',
                            textColor: Colors.white,
                            iconColor: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
