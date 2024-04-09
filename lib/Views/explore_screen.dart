import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Constants/styles.dart';
import 'package:movies_app/Controllers/explore_screen_controller.dart';
import 'package:movies_app/Controllers/movie_screen_controller.dart';
import 'package:movies_app/Views/movie_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ExploreScreen extends StatelessWidget {
  final ExploreScreenController exploreController =
      Get.put(ExploreScreenController(), permanent: true);
  final MovieScreenController movieController = MovieScreenController();

  ExploreScreen({super.key});

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
            color: MyColors.Blue,
            child: Center(
              child: Text(
                'Explore',
                style: MyStyles.myFontStyle.copyWith(
                  fontSize: width * height * 0.00011,
                ),
              ),
            ),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LiquidPullRefresh(
        color: MyColors.Blue,
        height: height * 0.434,
        backgroundColor: Colors.white,
        animSpeedFactor: 3,
        showChildOpacityTransition: false,
        onRefresh: () => exploreController.fetchFilmsAgain(),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.149,
                  left: width * 0.0260,
                ),
                child: Text(
                  "Featured Movies",
                  textAlign: TextAlign.start,
                  style: MyStyles.myFontStyle.copyWith(
                    fontSize: height * width * 0.000080,
                    color: MyColors.Blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GetBuilder(
                init: exploreController,
                builder: (controller) {
                  return (controller.isLoading == true) ||
                          (controller.isFailed == false)
                      ? (controller.movies.isEmpty)
                          ? SizedBox(
                              height: (height * 0.298) * 4,
                              child: Shimmer.fromColors(
                                period: const Duration(milliseconds: 500),
                                baseColor: Colors.grey[350]!,
                                highlightColor: Colors.white,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Container(
                                        height: height * 0.248,
                                        width: width * 0.78,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.circular(
                                              width * height * 0.000080),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                          : SizedBox(
                              height: ((height * 0.268) * 50) + height * 0.124,
                              child: AnimationLimiter(
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  itemCount: 50,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 375),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: SlideAnimation(
                                          child: InkWell(
                                            onTap: () {
                                              Get.to(
                                                () => MovieScreen(
                                                  movie:
                                                      controller.movies[index],
                                                ),
                                              );
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.039,
                                                  vertical: height * 0.0099),
                                              child: SizedBox(
                                                height: height * 0.248,
                                                width: width * 0.78,
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  children: [
                                                    Hero(
                                                      tag: controller
                                                          .movies[index],
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                height *
                                                                    width *
                                                                    0.000064),
                                                        child:
                                                            CachedNetworkImage(
                                                          fit: BoxFit.cover,
                                                          imageUrl: controller
                                                              .movies[index]
                                                              .imagePath,
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Container(
                                                            color: Colors.grey,
                                                            child: const Icon(
                                                                Icons.error),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment: Alignment
                                                          .bottomCenter,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          gradient:
                                                              const LinearGradient(
                                                            colors: [
                                                              Colors
                                                                  .transparent,
                                                              Colors.black
                                                            ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .bottomCenter,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    height *
                                                                        width *
                                                                        0.000064),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    height *
                                                                        width *
                                                                        0.000064),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      width *
                                                                          .020),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .end,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              ListTile(
                                                                title: Text(
                                                                  controller
                                                                      .movies[
                                                                          index]
                                                                      .name,
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: MyStyles
                                                                      .myFontStyle
                                                                      .copyWith(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize: height *
                                                                        width *
                                                                        0.000064,
                                                                  ),
                                                                ),
                                                                subtitle: Text(
                                                                  "${controller.movies[index].year}|${controller.movies[index].duration}|${controller.movies[index].rating}",
                                                                ),
                                                                subtitleTextStyle:
                                                                    MyStyles
                                                                        .myFontStyle
                                                                        .copyWith(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            )
                      : Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: height * 0.155,
                              bottom: height / 3.2,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Lottie.asset(
                                  'assets/animations/error.json',
                                  height: height * 0.310,
                                  width: width * 0.651,
                                ),
                                Text(
                                  exploreController.errorMessage,
                                  style: MyStyles.myFontStyle.copyWith(
                                    color: MyColors.Blue,
                                    fontSize: height * width * 0.000080,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                },
              ),
            ],
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
