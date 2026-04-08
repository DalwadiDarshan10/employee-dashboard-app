import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/name_routes.dart';

class SplashController extends GetxController {
  final storage = GetStorage();

  @override
  void onReady() {
    super.onReady();
    _startTimer();
  }

  void _startTimer() async {
    await Future.delayed(const Duration(seconds: 3));
    
    bool isLoggedIn = storage.read('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(NameRoutes.dashboard);
    } else {
      Get.offAllNamed(NameRoutes.login);
    }
  }
}
