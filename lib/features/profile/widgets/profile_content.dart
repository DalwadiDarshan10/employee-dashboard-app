import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../../../core/widgets/custom_image_view.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class ProfileContent extends GetView<DashboardController> {
  const ProfileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isProfileLoading.value) {
        return _buildShimmerSkeleton();
      } else {
        return _buildActualContent();
      }
    });
  }

  Widget _buildShimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 30.w, height: 30.w, color: AppColors.white),
                Container(width: 100.w, height: 24.h, color: AppColors.white),
                Container(width: 40.w, height: 24.h, color: AppColors.white),
              ],
            ),
            SizedBox(height: 40.h),
            Center(
              child: Container(
                width: 120.w,
                height: 120.w,
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Container(width: 150.w, height: 28.h, color: AppColors.white),
            SizedBox(height: 8.h),
            Container(width: 120.w, height: 18.h, color: AppColors.white),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                3,
                (index) => Container(
                  width: 100.w,
                  height: 120.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              height: 250.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            SizedBox(height: 20.h),
            ...List.generate(
              3,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Container(
                  width: double.infinity,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(30.r),
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildActualContent() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          SizedBox(height: 20.h),
          _buildAppBar(),
          SizedBox(height: 40.h),
          _buildProfileHeader(),
          SizedBox(height: 32.h),
          _buildStatsRow(),
          SizedBox(height: 30.h),
          _buildEmployeeInfoCard(),
          SizedBox(height: 24.h),
          _buildMenuItem(Icons.person_outline, AppStrings.profileEditMenu, onTap: () {}),
          _buildMenuItem(Icons.history, AppStrings.profilePasswordMenu, onTap: () {}),
          _buildMenuItem(
            Icons.notifications_none,
            AppStrings.profileNotificationMenu,
            onTap: () {},
          ),
          SizedBox(height: 32.h),
          _buildLogoutButton(),
          SizedBox(height: 100.h),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () => controller.changeTabIndex(0),
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        ),
        Text(
          AppStrings.profileTitle,
          style: CustomTextStyles.titleLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            AppStrings.profileEdit,
            style: CustomTextStyles.labelLarge.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.15),
                    blurRadius: 30,
                    spreadRadius: 10,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: const BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
              ),
              child: CustomImageView(
                imagePath:
                    "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80",
                height: 110.w,
                width: 110.w,
                radius: BorderRadius.circular(55.r),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Text(
          "Darshan Dalwadi",
          style: CustomTextStyles.displayLarge.copyWith(fontSize: 26.sp),
        ),
        SizedBox(height: 4.h),
        Text(
          "Software Engineer",
          style: CustomTextStyles.labelLarge.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          "darshan@email.com",
          style: CustomTextStyles.labelMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatCard(
          Icons.calendar_month,
          "94%",
          AppStrings.profileAttendance,
          iconBg: AppColors.statIconBg1,
          iconColor: AppColors.statIcon1,
        ),
        _buildStatCard(
          Icons.umbrella_outlined,
          "12",
          AppStrings.profileLeaves,
          iconBg: AppColors.statIconBg2,
          iconColor: AppColors.statIcon2,
        ),
        _buildStatCard(
          Icons.assignment_outlined,
          "03",
          AppStrings.profileRequests,
          iconBg: AppColors.statIconBg3,
          iconColor: AppColors.statIcon3,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label, {
    required Color iconBg,
    required Color iconColor,
  }) {
    return Container(
      width: 105.w,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [AppColors.softShadow],
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: CustomTextStyles.titleLarge.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: CustomTextStyles.labelSmall.copyWith(
              fontSize: 9.sp,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeInfoCard() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [AppColors.softShadow],
      ),
      child: Column(
        children: [
          _buildInfoRow(AppStrings.profileEmpId, "#EMP-8293", Icons.badge_outlined),
          const Divider(height: 32, color: AppColors.border),
          _buildInfoRow(
            AppStrings.profileDept,
            "Product Design",
            Icons.category_outlined,
          ),
          const Divider(height: 32, color: AppColors.border),
          _buildInfoRow(
            AppStrings.profileJoiningDate,
            "12 Jan 2022",
            Icons.calendar_today_outlined,
          ),
          const Divider(height: 32, color: AppColors.border),
          _buildInfoRow(
            AppStrings.profileLocation,
            "San Francisco, CA",
            Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: CustomTextStyles.labelSmall.copyWith(
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              value,
              style: CustomTextStyles.titleSmall.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
        Icon(icon, color: AppColors.border, size: 22.sp),
      ],
    );
  }

  Widget _buildMenuItem(
    IconData icon,
    String title, {
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [AppColors.softShadow],
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: AppColors.primary, size: 20.sp),
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: CustomTextStyles.titleSmall.copyWith(fontSize: 15.sp),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.textSecondary.withOpacity(0.5),
                  size: 20.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.logoutBg,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => controller.logout(),
          borderRadius: BorderRadius.circular(16.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.logout, color: AppColors.error, size: 20.sp),
              SizedBox(width: 12.w),
              Text(
                AppStrings.profileLogout,
                style: CustomTextStyles.titleSmall.copyWith(
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
