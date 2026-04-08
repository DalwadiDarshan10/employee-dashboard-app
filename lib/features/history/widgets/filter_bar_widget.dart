import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';

class FilterBarWidget extends StatelessWidget {
  final String selectedTime;
  final String selectedStatus;
  final Function(String) onTimeChanged;
  final Function(String) onStatusChanged;

  const FilterBarWidget({
    Key? key,
    required this.selectedTime,
    required this.selectedStatus,
    required this.onTimeChanged,
    required this.onStatusChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              _buildFilterChip(
                  "${AppStrings.historyLabelTime}: $selectedTime",
                  [
                    AppStrings.historyFilterAll,
                    AppStrings.historyFilterWeek,
                    AppStrings.historyFilterMonth,
                    AppStrings.historyFilterYear
                  ],
                  onTimeChanged,
                  active: true),
              _buildFilterChip(
                  "${AppStrings.historyLabelStatus}: $selectedStatus",
                  [
                    AppStrings.historyFilterAll,
                    AppStrings.historyFilterStatusApproved,
                    AppStrings.historyFilterStatusPending,
                    AppStrings.historyFilterStatusRejected
                  ],
                  onStatusChanged,
                  active: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, List<String> options, Function(String) onSelected, {bool active = false}) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (context) => options.map((String choice) {
        return PopupMenuItem<String>(value: choice, child: Text(choice));
      }).toList(),
      child: Container(
        margin: EdgeInsets.only(right: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: active ? AppColors.primary : AppColors.border,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: CustomTextStyles.labelMedium.copyWith(
                color: active ? AppColors.white : AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: active ? AppColors.white : AppColors.textSecondary,
              size: 18.sp,
            ),
          ],
        ),
      ),
    );
  }
}
