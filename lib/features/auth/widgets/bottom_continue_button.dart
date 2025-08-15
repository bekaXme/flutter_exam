import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_exam/colors.dart';

class BottomContinueButton extends StatelessWidget {
  String routerLocation;
  BottomContinueButton({
    this.routerLocation = '/getOTP',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(routerLocation);
      },
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.center,
          width: 207.w,
          height: 45.h,
          decoration: BoxDecoration(
            color: AppColors.pinkIcon,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Text(
            'Continue',
            style: TextStyle(
              color: AppColors.pinkIconBack,
              fontWeight: FontWeight.w600,
              fontSize: 20.sp,
            ),
          ),
        ),
      ),
    );
  }
}
