import 'package:get/get.dart';
import 'package:movies_app/Views/home_screen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() async {
    await Future.delayed(
      const Duration(
        seconds: 6,
      ),
      () {
        if (!isClosed) {
          Get.off(() => HomeScreen());
        }
      },
    );
    super.onInit();
  }
}
