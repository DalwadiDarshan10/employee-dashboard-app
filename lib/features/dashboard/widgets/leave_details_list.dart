import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../models/dashboard_model.dart';

class LeaveDetailsList extends StatelessWidget {
  final List<LeaveDetailModel> leaveDetails;
  final bool isExpanded;
  final VoidCallback onToggle;

  const LeaveDetailsList({
    Key? key,
    required this.leaveDetails,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayList = isExpanded ? leaveDetails : leaveDetails.take(2).toList();

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
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      AppStrings.historyTitle,
                      style: CustomTextStyles.titleSmall.copyWith(
                        color: AppColors.textPrimary.withOpacity(0.87),
                      ),
                    ),
                  ],
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayList.length,
              separatorBuilder: (context, index) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                final leave = displayList[index];
                return _buildLeaveItem(
                  leave.title,
                  "${leave.startDate} - ${leave.endDate}",
                  leave.status.capitalizeFirst ?? leave.status,
                  _getBadgeBgColor(leave.status),
                  _getBadgeTextColor(leave.status),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Color _getBadgeBgColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.success.withOpacity(0.1);
      case 'pending':
        return AppColors.statIconBg1;
      case 'rejected':
        return AppColors.logoutBg;
      default:
        return AppColors.background;
    }
  }

  Color _getBadgeTextColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return AppColors.success;
      case 'pending':
        return AppColors.primary;
      case 'rejected':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Widget _buildLeaveItem(
    String title,
    String date,
    String status,
    Color badgeBg,
    Color badgeText,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: CustomTextStyles.titleSmall.copyWith(
                fontSize: 15.sp,
                color: AppColors.textPrimary.withOpacity(0.87),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              date,
              style: CustomTextStyles.labelMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: badgeBg,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Text(
            status,
            style: CustomTextStyles.labelMedium.copyWith(
              color: badgeText,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
