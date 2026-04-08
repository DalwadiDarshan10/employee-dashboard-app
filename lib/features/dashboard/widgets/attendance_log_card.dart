import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../models/dashboard_model.dart';

class AttendanceLogCard extends StatelessWidget {
  final List<AttendanceLogModel> attendanceLogs;
  final bool isExpanded;
  final VoidCallback onToggle;

  const AttendanceLogCard({
    Key? key,
    required this.attendanceLogs,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayList = isExpanded ? attendanceLogs : attendanceLogs.take(1).toList();

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
                      Icons.history,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      AppStrings.dashboardAttendanceLogs,
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
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final log = displayList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: log.status == 'on_time' 
                                ? AppColors.success 
                                : AppColors.statIconOrange,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          index == 0 && !isExpanded ? "${AppStrings.dashboardToday}, ${log.time}" : log.time,
                          style: CustomTextStyles.titleSmall.copyWith(
                            fontSize: 15.sp,
                            color: AppColors.textPrimary.withOpacity(0.87),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      log.status.replaceAll('_', '-').toUpperCase(),
                      style: CustomTextStyles.labelMedium.copyWith(
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
