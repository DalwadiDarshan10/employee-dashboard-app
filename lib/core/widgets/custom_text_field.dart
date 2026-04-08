import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/custom_text_style.dart';
import '../constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? errorText;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final Widget? labelTrailing;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.labelTrailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: CustomTextStyles.labelLarge,
            ),
            if (label.contains('*') || label == 'Email Address' || label == 'Password') ...[
              SizedBox(width: 4.w),
              Text(
                '*',
                style: CustomTextStyles.labelLarge.copyWith(color: AppColors.error),
              ),
            ],
            if (labelTrailing != null) ...[
              const Spacer(),
              labelTrailing!,
            ]
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: hasError ? AppColors.error : AppColors.inputBorder,
              width: 1.5,
            ),
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            style: CustomTextStyles.bodyLarge,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: CustomTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
              prefixIcon: prefixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                        color: hasError ? AppColors.error : AppColors.textSecondary,
                        size: 20.r,
                      ),
                      child: prefixIcon!,
                    )
                  : null,
              suffixIcon: suffixIcon != null
                  ? IconTheme(
                      data: IconThemeData(
                        color: AppColors.textSecondary,
                        size: 20.r,
                      ),
                      child: suffixIcon!,
                    )
                  : null,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            ),
          ),
        ),
        if (hasError) ...[
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.error_outline, color: AppColors.error, size: 16.r),
              SizedBox(width: 4.w),
              Text(
                errorText!,
                style: CustomTextStyles.errorText,
              ),
            ],
          )
        ]
      ],
    );
  }
}
