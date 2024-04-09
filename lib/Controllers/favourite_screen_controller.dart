import 'package:get/get.dart';
import 'package:movies_app/Models/movie_model.dart';

class FavouriteScreenController extends GetxController {
  List favouriteMovies = List<Movie>.empty(growable: true).obs;
}
