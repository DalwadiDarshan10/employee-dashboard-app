import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../models/dashboard_model.dart';

class HolidayListCard extends StatelessWidget {
  final List<HolidayModel> holidays;
  final bool isExpanded;
  final VoidCallback onToggle;

  const HolidayListCard({
    Key? key,
    required this.holidays,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayList = isExpanded ? holidays : holidays.take(1).toList();

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
                      Icons.celebration_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      AppStrings.dashboardUpcomingHolidays,
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
                final holiday = displayList[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      holiday.name,
                      style: CustomTextStyles.titleSmall.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.textPrimary.withOpacity(0.87),
                      ),
                    ),
                    Text(
                      holiday.date,
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
