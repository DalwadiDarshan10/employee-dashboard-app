import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../models/dashboard_model.dart';

class AttendanceCard extends StatelessWidget {
  final AttendanceModel attendance;

  const AttendanceCard({Key? key, required this.attendance}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [AppColors.softShadow],
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.calendar_today,
              size: 60.sp,
              color: AppColors.textSecondary.withOpacity(0.1),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: const BoxDecoration(
                      color: AppColors.statIconBg1,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.event_available,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    AppStrings.dashboardAttendanceTitle,
                    style: CustomTextStyles.titleSmall.copyWith(
                      color: AppColors.textPrimary.withOpacity(0.87),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "${attendance.percentage}%",
                    style: CustomTextStyles.displayLarge.copyWith(
                      fontSize: 36.sp,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Padding(
                    padding: EdgeInsets.only(bottom: 6.h),
                    child: Text(
                      "+${attendance.monthlyGrowth}% ${AppStrings.dashboardThisMonth}",
                      style: CustomTextStyles.labelMedium.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(10.r),
                child: LinearProgressIndicator(
                  value: attendance.percentage / 100,
                  backgroundColor: AppColors.background,
                  color: AppColors.primary,
                  minHeight: 8.h,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
