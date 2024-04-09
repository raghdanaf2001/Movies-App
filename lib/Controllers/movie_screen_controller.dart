import 'package:get/get.dart';
import 'package:movies_app/Controllers/favourite_screen_controller.dart';
import 'package:movies_app/Models/movie_model.dart';

class MovieScreenController extends GetxController {
  FavouriteScreenController favouriteScreenController =
      Get.put(FavouriteScreenController());

  void addToFavorite(Movie movie) {
    if (movie.favourite == false) {
      movie.favourite = true;
      favouriteScreenController.favouriteMovies.add(movie);
      update();
    } else {
      movie.favourite = false;
      favouriteScreenController.favouriteMovies.remove(movie);
      update();
    }
  }
}
