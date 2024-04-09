import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  int pageIndex = 0;
  PageController? pageController;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    super.onInit();
  }
}
