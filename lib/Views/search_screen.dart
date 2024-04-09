import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Constants/styles.dart';
import 'package:movies_app/Controllers/search_screen_controller.dart';
import 'package:movies_app/Views/movie_screen.dart';

class SearchScreen extends StatelessWidget {
  final SearchScreenController searchScreenController =
      Get.put(SearchScreenController(), permanent: true);

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FocusScope(
      child: Scaffold(
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
                  'Search',
                  style: MyStyles.myFontStyle.copyWith(
                    fontSize: width * height * 0.00011,
                  ),
                ),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: GetBuilder(
          init: searchScreenController,
          builder: (controller) => Column(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: height * 0.149, right: width * 0.039),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: controller.isFolded ? width * 0.146 : width * 0.911,
                    height: height * 0.0695,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(height * width * 0.00010),
                      color: MyColors.Blue,
                      boxShadow: kElevationToShadow[8],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: width * 0.0416),
                            child: !controller.isFolded
                                ? TextField(
                                    controller: controller.searchController,
                                    cursorColor: Colors.white,
                                    style: MyStyles.myFontStyle,
                                    decoration: const InputDecoration(
                                      hintText: "Search here...",
                                      hintStyle: TextStyle(color: Colors.white),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      controller.filter(value);
                                    },
                                  )
                                : null,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(height * width * 0.0000517),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(controller.isFolded
                                    ? height * width * 0.00010
                                    : 0),
                                bottomLeft: Radius.circular(controller.isFolded
                                    ? height * width * 0.00010
                                    : 0),
                                topRight:
                                    Radius.circular(height * width * 0.00010),
                                bottomRight:
                                    Radius.circular(height * width * 0.00010),
                              ),
                              onTap: () {
                                controller.searchBarAnimation();
                              },
                              child: Icon(
                                controller.isFolded
                                    ? Icons.search
                                    : Icons.close,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              controller.isFolded == false
                  ? Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.only(
                            top: height * 0.0248, bottom: height * 0.124),
                        itemCount: controller.filteredMovies.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              Get.to(
                                () => MovieScreen(
                                  movie: controller.filteredMovies[index],
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.0390,
                                  vertical: height * 0.0099),
                              child: SizedBox(
                                height: height * 0.248,
                                width: width * 0.78,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Hero(
                                      tag: controller.filteredMovies[index],
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            height * width * 0.000064),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: controller
                                              .filteredMovies[index].imagePath,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey,
                                            child: const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(
                                                height * width * 0.000064),
                                            bottomRight: Radius.circular(
                                                height * width * 0.000064),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: width * 0.020),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ListTile(
                                                title: Text(
                                                  controller
                                                      .filteredMovies[index]
                                                      .name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: MyStyles.myFontStyle
                                                      .copyWith(
                                                    color: Colors.white,
                                                    fontSize: height *
                                                        width *
                                                        0.000064,
                                                  ),
                                                ),
                                                subtitle: Text(
                                                  "${controller.filteredMovies[index].year}|${controller.filteredMovies[index].duration}|${controller.filteredMovies[index].rating}",
                                                ),
                                                subtitleTextStyle: MyStyles
                                                    .myFontStyle
                                                    .copyWith(
                                                  color: Colors.white,
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
                          );
                        },
                      ),
                    )
                  : Align(
                      alignment: Alignment.center,
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
                                'assets/animations/search.json',
                                fit: BoxFit.cover,
                                repeat: true,
                              ),
                            ),
                          ],
                        ),
                      ),
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
