import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/login_controller.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/theme/custom_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Obx(
                () => Opacity(
                  opacity: controller.isLoading.value ? 0.6 : 1.0,
                  child: AbsorbPointer(
                    absorbing: controller.isLoading.value,
                    child: Container(
                      padding: EdgeInsets.all(32.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(40.r),
                        boxShadow: [AppColors.softShadow],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.loginWelcome,
                            style: CustomTextStyles.displayLarge.copyWith(
                              fontSize: 32.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            AppStrings.loginSubTitle,
                            style: CustomTextStyles.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 40.h),
                          Obx(
                            () => CustomTextField(
                              label: AppStrings.loginEmailLabel,
                              hintText: AppStrings.loginEmailHint,
                              controller: controller.emailController,
                              prefixIcon: const Icon(Icons.email_outlined),
                              errorText: controller.emailError.value,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (_) {
                                if (controller.emailError.value.isNotEmpty) {
                                  controller.validateParameters();
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Obx(
                            () => CustomTextField(
                              label: AppStrings.loginPasswordLabel,
                              hintText: AppStrings.loginPasswordHint,
                              controller: controller.passwordController,
                              obscureText: controller.isPasswordObscured.value,
                              prefixIcon: const Icon(Icons.lock_outline),
                              errorText: controller.passwordError.value,
                              onChanged: (_) {
                                if (controller.passwordError.value.isNotEmpty) {
                                  controller.validateParameters();
                                }
                              },
                              labelTrailing: GestureDetector(
                                onTap: () {},
                                child: Text(
                                  AppStrings.loginForgotPassword,
                                  style: CustomTextStyles.labelLarge.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              suffixIcon: GestureDetector(
                                onTap: controller.togglePasswordVisibility,
                                child: Icon(
                                  controller.isPasswordObscured.value
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Obx(
                            () => CustomButton(
                              text: AppStrings.loginSignIn,
                              onPressed: controller.login,
                              isLoading: controller.isLoading.value,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColors.primary.withOpacity(0.1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  color: AppColors.primary,
                                  size: 20.sp,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: Text.rich(
                                    TextSpan(
                                      text: AppStrings.loginDemoAccess,
                                      style: CustomTextStyles.labelMedium
                                          .copyWith(
                                            color: AppColors.primary,
                                            fontWeight: FontWeight.bold,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: 'admin@gmail.com \nadmin123',
                                          style: CustomTextStyles.labelMedium
                                              .copyWith(
                                                color: AppColors.textPrimary,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 24.h),
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Text(
                                  AppStrings.loginOrConnect,
                                  style: CustomTextStyles.labelMedium.copyWith(
                                    letterSpacing: 1.2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.border,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          Center(
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                Text(
                                  AppStrings.loginNewPlatform,
                                  style: CustomTextStyles.bodyMedium.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Text(
                                    AppStrings.loginContactHR,
                                    style: CustomTextStyles.bodyMedium.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                AppStrings.loginCopyright,
                style: CustomTextStyles.labelSmall.copyWith(
                  letterSpacing: 2,
                  color: AppColors.textSecondary.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
