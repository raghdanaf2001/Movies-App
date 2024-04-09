import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/Controllers/explore_screen_controller.dart';
import 'package:movies_app/Models/movie_model.dart';

class SearchScreenController extends GetxController {
  bool isFolded = true;
  ExploreScreenController exploreController = Get.find();
  List<Movie> filteredMovies = [];
  TextEditingController searchController = TextEditingController();

  void filter(String name) {
    if (name.trim().isEmpty) {
      filteredMovies.clear();
      update();
    } else {
      filteredMovies = exploreController.movies
          .where((movie) => movie.name.toLowerCase().contains(name))
          .toList();
      update();
    }
  }

  void searchBarAnimation() {
    if (isFolded) {
      isFolded = false;
      update();
    } else {
      isFolded = true;
      update();
    }
    if (isFolded) {
      filteredMovies.clear();
      searchController.text = "";
      update();
    }
  }

  @override
  void onClose() {
    print("object");
    isFolded = true;
    searchController.text = "";
    filteredMovies.clear();
    super.onClose();
  }
}
