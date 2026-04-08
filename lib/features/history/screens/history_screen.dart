import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../controllers/history_controller.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/balance_card_widget.dart';
import '../widgets/filter_bar_widget.dart';
import '../widgets/leave_history_item_widget.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return _buildShimmerSkeleton();
      }
      return _buildActualContent();
    });
  }

  Widget _buildActualContent() {
    return RefreshIndicator(
      onRefresh: controller.onRefresh,
      color: AppColors.primary,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            _buildHeader(),
            SizedBox(height: 32.h),
            ProfileHeaderWidget(user: controller.user.value),
            SizedBox(height: 32.h),
            BalanceCardWidget(
              balance: controller.currentBalance,
              total: controller.totalLeaves,
              used: controller.usedLeaves,
            ),
            SizedBox(height: 32.h),
            FilterBarWidget(
              selectedTime: controller.selectedTimeFilter.value,
              selectedStatus: controller.selectedStatus.value,
              onTimeChanged: controller.filterByTime,
              onStatusChanged: controller.filterByStatus,
            ),
            SizedBox(height: 32.h),
            Text(
              AppStrings.dashboardHistory,
              style: CustomTextStyles.displayLarge.copyWith(fontSize: 24.sp),
            ),
            SizedBox(height: 20.h),
            _buildHistoryList(),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          AppStrings.historyTitle,
          style: CustomTextStyles.titleMedium.copyWith(
            fontSize: 20.sp, 
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryList() {
    if (controller.filteredLeaves.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Icon(Icons.search_off_rounded, size: 60.sp, color: AppColors.border),
              SizedBox(height: 16.h),
              Text(AppStrings.noDataFound, style: CustomTextStyles.bodyLarge.copyWith(color: AppColors.textSecondary)),
            ],
          ),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.filteredLeaves.length,
      itemBuilder: (context, index) {
        return LeaveHistoryItemWidget(leave: controller.filteredLeaves[index]);
      },
    );
  }

  Widget _buildShimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Center(child: Container(width: 150.w, height: 24.h, color: AppColors.white)),
            SizedBox(height: 32.h),
            Row(
              children: [
                Container(width: 84.w, height: 84.w, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(20.r))),
                SizedBox(width: 20.w),
                Column(children: [
                  Container(width: 150.w, height: 24.h, color: AppColors.white),
                  SizedBox(height: 8.h),
                  Container(width: 100.w, height: 16.h, color: AppColors.white),
                ]),
              ],
            ),
            SizedBox(height: 32.h),
            Container(width: double.infinity, height: 140.h, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(30.r))),
            SizedBox(height: 24.h),
            Row(children: [
              Expanded(child: Container(height: 100.h, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r)))),
              SizedBox(width: 16.w),
              Expanded(child: Container(height: 100.h, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r)))),
            ]),
            SizedBox(height: 32.h),
            Container(width: 200.w, height: 40.h, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(16.r))),
            SizedBox(height: 32.h),
            ...List.generate(3, (index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Container(width: double.infinity, height: 100.h, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(24.r))),
            )),
          ],
        ),
      ),
    );
  }
}
