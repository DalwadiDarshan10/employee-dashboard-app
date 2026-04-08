import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/custom_text_style.dart';
import '../../../data/models/user_model.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserModel? user;

  const ProfileHeaderWidget({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 84.w,
          height: 84.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [AppColors.softShadow],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Image.network(
              user?.imageUrl ?? '',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.border,
                child: Icon(Icons.person, color: AppColors.textSecondary.withOpacity(0.5), size: 40.sp),
              ),
            ),
          ),
        ),
        SizedBox(width: 20.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name ?? AppStrings.profileNamePlaceholder,
              style: CustomTextStyles.displayLarge.copyWith(
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              user?.role.toUpperCase() ?? AppStrings.profileRolePlaceholder,
              style: CustomTextStyles.labelLarge.copyWith(
                color: AppColors.textSecondary,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
