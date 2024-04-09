import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/Constants/styles.dart';
import 'package:movies_app/Controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: height / 2.2,
            width: width,
            child: Image.asset(
              "assets/images/logo.png",
              fit: BoxFit.fill,
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
                  stops: [0.2, 0.4],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Discover movies' world in one app",
              style: MyStyles.myFontStyle
                  .copyWith(fontSize: height * width * 0.000064),
            ),
          ),
          Positioned(
            top: height * 0.55,
            left: width * 0.260,
            child: Lottie.asset(
              "assets/animations/splash.json",
              height: height * 0.248,
              width: width * 0.52,
            ),
          ),
        ],
      ),
    );
  }
}
