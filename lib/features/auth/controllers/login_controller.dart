import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../routes/name_routes.dart';

class LoginController extends GetxController {
  final storage = GetStorage();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  final RxBool isPasswordObscured = true.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordObscured.value = !isPasswordObscured.value;
  }

  bool validateParameters() {
    bool isValid = true;
    emailError.value = '';
    passwordError.value = '';

    if (emailController.text.trim().isEmpty) {
      emailError.value = AppStrings.emailEmptyError;
      isValid = false;
    } else if (!GetUtils.isEmail(emailController.text.trim())) {
      emailError.value = AppStrings.emailInvalidError;
      isValid = false;
    }

    if (passwordController.text.isEmpty) {
      passwordError.value = AppStrings.passwordEmptyError;
      isValid = false;
    } else if (passwordController.text.length < 6) {
      passwordError.value = AppStrings.passwordLengthError;
      isValid = false;
    }

    return isValid;
  }

  void login() async {
    if (!validateParameters()) return;

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    isLoading.value = false;

    String email = emailController.text.trim();
    String password = passwordController.text;

    if (email == 'admin@gmail.com' && password == 'admin123') {
      await storage.write('isLoggedIn', true);
      
      Get.snackbar(
        AppStrings.success,
        AppStrings.loginSuccess,
        backgroundColor: AppColors.success.withOpacity(0.9),
        colorText: AppColors.white,
      );
      
      Get.offAllNamed(NameRoutes.dashboard);
    } else {
      Get.snackbar(
        AppStrings.loginAuthError,
        AppStrings.loginInvalidCreds,
        backgroundColor: AppColors.error.withOpacity(0.9),
        colorText: AppColors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
