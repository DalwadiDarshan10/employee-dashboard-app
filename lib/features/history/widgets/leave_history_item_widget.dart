import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../../../data/models/leave_history_model.dart';

class LeaveHistoryItemWidget extends StatelessWidget {
  final LeaveHistoryModel leave;

  const LeaveHistoryItemWidget({Key? key, required this.leave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: _getIconBgColor(),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(_getIconData(), color: _getIconColor(), size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      leave.title,
                      style: CustomTextStyles.titleSmall.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor().withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        leave.status.toUpperCase(),
                        style: CustomTextStyles.labelSmall.copyWith(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.bold,
                          fontSize: 10.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  "${leave.startDate} - ${leave.endDate}",
                  style: CustomTextStyles.bodyMedium.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "${leave.daysCount} ${AppStrings.balanceUsed.split(' ').last}",
                  style: CustomTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.bold,
                    fontSize: 11.sp,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor() {
    switch (leave.status.toLowerCase()) {
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

  IconData _getIconData() {
    switch (leave.type.toLowerCase()) {
      case 'medical':
        return Icons.medical_services_rounded;
      case 'vacation':
        return Icons.flight_takeoff_rounded;
      default:
        return Icons.event_note_rounded;
    }
  }

  Color _getIconBgColor() {
    switch (leave.type.toLowerCase()) {
      case 'medical':
        return AppColors.statIconBg1;
      case 'vacation':
        return AppColors.logoutBg;
      default:
        return AppColors.statIconBg2;
    }
  }

  Color _getIconColor() {
    switch (leave.type.toLowerCase()) {
      case 'medical':
        return AppColors.statIcon1;
      case 'vacation':
        return AppColors.error;
      default:
        return AppColors.primary;
    }
  }
}
