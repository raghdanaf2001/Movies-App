import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:movies_app/Constants/strings.dart';
import 'package:movies_app/Controllers/movie_screen_controller.dart';
import 'package:movies_app/Models/movie_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieScreen extends StatelessWidget {
  final Movie movie;
  final MovieScreenController movieController = MovieScreenController();
  MovieScreen({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            color: const Color(0xFF000B49),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * 0.745,
              width: width,
              child: Hero(
                tag: movie,
                child: CachedNetworkImage(
                  imageUrl: movie.imagePath,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Center(
                    child: Container(
                      color: Colors.transparent,
                      child: const Icon(
                        Icons.error,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color(0xFF000B49),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.3, 0.5],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.186,
            width: width,
            child: Padding(
              padding: EdgeInsets.all(height * width * 0.000064),
              child: Column(
                children: [
                  Text(
                    movie.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * width * 0.000064,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.0124),
                  Text(
                    '${movie.year} | ${movie.duration} ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * width * 0.000045,
                    ),
                  ),
                  SizedBox(height: height * 0.0124),
                  RatingBar.builder(
                    initialRating:
                        (double.parse(movie.rating.substring(0, 2))) / 2,
                    minRating: 1,
                    maxRating: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    ignoreGestures: true,
                    itemCount: 5,
                    itemSize: height * width * 0.000064,
                    unratedColor: Colors.white,
                    itemPadding:
                        EdgeInsets.symmetric(horizontal: width * 0.0104),
                    itemBuilder: (context, index) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    },
                    onRatingUpdate: (rating) {},
                  ),
                  SizedBox(height: height * 0.0248),
                  Text(
                    MyStrings.descreption,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          height: height * 0.00217,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: height * 0.055,
            width: width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.0520),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GetBuilder(
                    init: movieController,
                    builder: (controller) => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                        fixedSize: Size(width * 0.7, height * 0.062),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(height * width * 0.0000485),
                        ),
                      ),
                      onPressed: () {
                        controller.addToFavorite(movie);
                      },
                      child: RichText(
                        text: TextSpan(
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: Colors.white),
                          children: [
                            TextSpan(
                              text:
                                  movie.favourite ? "Remove from " : "Add to ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const TextSpan(
                              text: 'Watch List',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.0248),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(height * width * 0.0000485),
                      backgroundColor: Colors.white,
                      fixedSize: Size(width * 0.7, height * 0.062),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(height * width * 0.0000485),
                      ),
                    ),
                    onPressed: () async {
                      try {
                        final Uri url = Uri.parse(
                            'https://google.com/search?q=${movie.name}');
                        if (!await launchUrl(url)) {
                          throw Exception('Could not launch $url');
                        }
                      } catch (e) {
                        //
                      }
                    },
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyLarge,
                        children: [
                          TextSpan(
                            text: 'Search ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const TextSpan(
                            text: 'About',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
