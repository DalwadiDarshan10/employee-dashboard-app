import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../models/dashboard_model.dart';

class LeaveStatusCards extends StatelessWidget {
  final LeaveSummaryModel leaves;
  final RequestSummaryModel requests;

  const LeaveStatusCards({
    Key? key,
    required this.leaves,
    required this.requests,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildInfoCard(
            icon: Icons.umbrella,
            iconColor: AppColors.statIconOrange,
            iconBg: AppColors.statIconBgOrange,
            title: AppStrings.dashboardLeavesLabel,
            value: "${leaves.usedLeaves.toString().padLeft(2, '0')}/${leaves.totalLeaves.toString().padLeft(2, '0')}",
            progress: leaves.usedLeaves / leaves.totalLeaves,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildInfoCard(
            icon: Icons.assignment_outlined,
            iconColor: AppColors.primary,
            iconBg: AppColors.statIconBg1,
            title: AppStrings.dashboardRequestsLabel,
            value: requests.pendingRequests.toString().padLeft(2, '0'),
            progress: 0.3,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String value,
    required double progress,
  }) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [AppColors.softShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20.sp),
          ),
          SizedBox(height: 20.h),
          Text(
            title,
            style: CustomTextStyles.labelMedium.copyWith(
              color: AppColors.textPrimary.withOpacity(0.6),
              letterSpacing: 1.1,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: CustomTextStyles.displayLarge.copyWith(fontSize: 24.sp),
          ),
          SizedBox(height: 16.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.background,
              color: AppColors.primary,
              minHeight: 6.h,
            ),
          ),
        ],
      ),
    );
  }
}
