import 'dart:convert';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:movies_app/Constants/strings.dart';
import 'package:movies_app/Models/movie_model.dart';
import 'package:http/http.dart' as http;

class ExploreScreenController extends GetxController {
  List<Movie> movies = [];
  bool isLoading = true;
  bool isFailed = false;
  bool done = false;
  String errorMessage = "";

  Future fetchFilms() async {
    try {
      var response = await http.get(
        Uri.parse(MyStrings.moviesUrl),
        headers: {
          'X-RapidAPI-Key': MyStrings.xRapidApiKey,
          'X-RapidAPI-Host': MyStrings.xRapidApiHost,
        },
      );
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List moviesList = jsonData['movies'];
        for (int i = 0; i < 50; i++) {
          movies.add(
            Movie.fromJson(moviesList[i]),
          );
        }
        movies;
        isLoading = false;
        done = true;
        update();
      } else {
        isFailed = true;
        isLoading = false;
        errorMessage = "Please turn on the VPN";
        update();
      }
    } catch (e) {
      isFailed = true;
      isLoading = false;
      errorMessage = "Please  turn on the internet";
      update();
    }
  }

  Future fetchFilmsAgain() async {
    isLoading = true;
    isFailed = false;
    done = false;
    errorMessage = "";
    movies = [];
    await Future.delayed(
      const Duration(
        seconds: 2,
      ),
      () {
        if (!isClosed) {
          fetchFilms();
        }
      },
    );
  }

  @override
  void onInit() {
    if (done != true) {
      fetchFilms();
      Future.delayed(
        const Duration(seconds: 4),
        () {
          if (!isClosed) {
            isLoading = false;
            done = true;
            update();
          }
        },
      );
      super.onInit();
    }
  }
}
