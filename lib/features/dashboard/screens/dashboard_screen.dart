import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../controllers/dashboard_controller.dart';
import '../../profile/widgets/profile_content.dart';
import '../../history/screens/history_screen.dart';
import '../widgets/attendance_card.dart';
import '../widgets/leave_status_cards.dart';
import '../widgets/leave_details_list.dart';
import '../widgets/attendance_log_card.dart';
import '../widgets/holiday_list_card.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return _buildShimmerSkeleton();
          } else if (controller.isError.value) {
            return _buildErrorState();
          } else {
            switch (controller.selectedIndex.value) {
              case 0:
                return _buildHomeContent();
              case 1:
                return const HistoryScreen();
              case 3:
                return const ProfileContent();
              default:
                return Center(
                  child: Text(
                    AppStrings.dashboardComingSoon,
                    style: CustomTextStyles.displayLarge,
                  ),
                );
            }
          }
        }),
      ),
      bottomNavigationBar: Obx(() {
        if (controller.isLoading.value && controller.dashboardData.value == null) {
          return const SizedBox.shrink();
        }
        return _buildBottomNavigationBar();
      }),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 60.sp, color: AppColors.error.withOpacity(0.6)),
          SizedBox(height: 16.h),
          Text(
            AppStrings.somethingWentWrong,
            style: CustomTextStyles.titleMedium,
          ),
          SizedBox(height: 8.h),
          ElevatedButton(
            onPressed: () => controller.fetchDashboardInfo(),
            child: Text(AppStrings.retry),
          ),
        ],
      ),
    );
  }

  Widget _buildShimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(width: 24.w, height: 24.w, color: AppColors.white),
                  Container(width: 150.w, height: 40.h, color: AppColors.white),
                  Container(width: 36.w, height: 36.w, color: AppColors.white),
                ],
              ),
              SizedBox(height: 30.h),
              Container(width: 250.w, height: 28.h, color: AppColors.white),
              SizedBox(height: 8.h),
              Container(width: 200.w, height: 16.h, color: AppColors.white),
              SizedBox(height: 24.h),
              Container(width: double.infinity, height: 140.h, color: AppColors.white),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(child: Container(height: 140.h, color: AppColors.white)),
                  SizedBox(width: 16.w),
                  Expanded(child: Container(height: 140.h, color: AppColors.white)),
                ],
              ),
              SizedBox(height: 16.h),
              Container(height: 160.h, color: AppColors.white),
              SizedBox(height: 16.h),
              Container(height: 100.h, color: AppColors.white),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    final data = controller.dashboardData.value;
    if (data == null) return const SizedBox.shrink();

    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      color: AppColors.primary,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Icon(Icons.menu, color: AppColors.primary, size: 28.sp),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Text(
                      AppStrings.dashboardTitle,
                      style: CustomTextStyles.titleMedium.copyWith(
                        color: AppColors.primary,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              Text(
                "${controller.getGreeting()}, Darshan",
                style: CustomTextStyles.displayLarge.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.textPrimary.withOpacity(0.87),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                AppStrings.dashboardOverview,
                style: CustomTextStyles.bodyMedium.copyWith(
                  color: AppColors.textPrimary.withOpacity(0.54),
                ),
              ),
              SizedBox(height: 24.h),
              AttendanceCard(attendance: data.attendance),
              SizedBox(height: 16.h),
              LeaveStatusCards(leaves: data.leaves, requests: data.requests),
              SizedBox(height: 16.h),
              LeaveDetailsList(
                leaveDetails: data.leaveDetails,
                isExpanded: controller.isLeaveExpanded.value,
                onToggle: controller.toggleLeave,
              ),
              SizedBox(height: 16.h),
              AttendanceLogCard(
                attendanceLogs: data.attendanceLogs,
                isExpanded: controller.isAttendanceExpanded.value,
                onToggle: controller.toggleAttendance,
              ),
              SizedBox(height: 16.h),
              HolidayListCard(
                holidays: data.upcomingHolidays,
                isExpanded: controller.isHolidayExpanded.value,
                onToggle: controller.toggleHoliday,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(Icons.grid_view_rounded, AppStrings.dashboardHome, 0),
            _buildNavItem(Icons.history_rounded, AppStrings.dashboardHistory, 1),
            _buildNavItem(Icons.bar_chart_outlined, AppStrings.dashboardStats, 2),
            _buildNavItem(Icons.person_outline, AppStrings.dashboardProfile, 3),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: isActive
            ? BoxDecoration(
                color: AppColors.navActiveBg,
                borderRadius: BorderRadius.circular(16.r),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.navActive : AppColors.navInactive,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: CustomTextStyles.labelSmall.copyWith(
                color: isActive ? AppColors.navActive : AppColors.navInactive,
                fontSize: 10.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
