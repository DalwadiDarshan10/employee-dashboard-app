import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/custom_text_style.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';

class BalanceCardWidget extends StatelessWidget {
  final int balance;
  final int total;
  final int used;

  const BalanceCardWidget({
    Key? key,
    required this.balance,
    required this.total,
    required this.used,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: AppColors.balanceCardGradient,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.balanceCardShadow,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Opacity(
                  opacity: 0.15,
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 140.sp,
                    color: AppColors.white,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.balanceCurrent,
                    style: CustomTextStyles.labelMedium.copyWith(
                      color: AppColors.white.withOpacity(0.9),
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        balance.toString(),
                        style: CustomTextStyles.displayLarge.copyWith(
                          color: AppColors.white,
                          fontSize: 48.sp,
                          height: 1,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Text(
                          AppStrings.balanceDaysLeft,
                          style: CustomTextStyles.bodyLarge.copyWith(
                            color: AppColors.white.withOpacity(0.9),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24.h),
        Row(
          children: [
            Expanded(child: _buildValueCard(AppStrings.balanceTotal, total.toString())),
            SizedBox(width: 16.w),
            Expanded(child: _buildValueCard(AppStrings.balanceUsed, used.toString())),
          ],
        ),
      ],
    );
  }

  Widget _buildValueCard(String label, String value) {
    return Container(
      padding: EdgeInsets.all(24.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: CustomTextStyles.labelSmall.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.1,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: CustomTextStyles.displayLarge.copyWith(fontSize: 32.sp),
          ),
        ],
      ),
    );
  }
}
