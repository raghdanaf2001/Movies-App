import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Constants/styles.dart';
import 'package:movies_app/Controllers/favourite_screen_controller.dart';
import 'package:movies_app/Controllers/movie_screen_controller.dart';
import 'package:movies_app/Views/movie_screen.dart';

class FavouriteScreen extends StatelessWidget {
  final FavouriteScreenController favouriteController = Get.find();
  final MovieScreenController movieScreenController = MovieScreenController();

  FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height * 0.124,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: _CustomClipper(),
          child: Container(
            height: height * 0.186,
            width: MediaQuery.of(context).size.width,
            color: const Color(0xFF000B49),
            child: Center(
              child: Text(
                'Favourite',
                style: MyStyles.myFontStyle.copyWith(
                  fontSize: width * height * 0.00011,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        child: Obx(
          () => favouriteController.favouriteMovies.isNotEmpty
              ? AnimationLimiter(
                  child: GridView.builder(
                    padding: EdgeInsets.only(
                      top: height * 0.155,
                      bottom: width * 0.260,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 6 / 11,
                    ),
                    itemCount: favouriteController.favouriteMovies.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        columnCount: 2,
                        duration: const Duration(milliseconds: 375),
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Padding(
                              padding:
                                  EdgeInsets.all(height * width * 0.0000258),
                              child: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => MovieScreen(
                                      movie: favouriteController
                                          .favouriteMovies[index],
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              height * width * 0.000080),
                                          child: Hero(
                                            tag: favouriteController
                                                .favouriteMovies[index],
                                            child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: favouriteController
                                                    .favouriteMovies[index]
                                                    .imagePath),
                                          ),
                                        ),
                                        Container(
                                          height: height * 0.327,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                height * width * 0.000080),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Colors.transparent,
                                                Colors.black
                                              ],
                                              begin: Alignment.center,
                                              end: Alignment.bottomCenter,
                                              stops: [0.6, 0.9],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.390,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            favouriteController
                                                .favouriteMovies[index].rating,
                                            style:
                                                MyStyles.myFontStyle.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.390,
                                      child: Text(
                                        favouriteController
                                            .favouriteMovies[index].name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: MyStyles.myFontStyle.copyWith(
                                          fontSize: height * width * 0.000064,
                                          fontWeight: FontWeight.bold,
                                          color: MyColors.Blue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.155),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: height * 0.310,
                          width: width * 0.651,
                          child: Lottie.asset(
                            'assets/animations/emptyList.json',
                            fit: BoxFit.cover,
                            repeat: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - (height * 0.406));
    path.quadraticBezierTo(
        width / (width * 0.00520), height, width, height - (height * 0.406));
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
