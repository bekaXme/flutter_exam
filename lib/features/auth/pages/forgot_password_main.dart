import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_exam/colors.dart';
import '../widgets/bottom_continue_button.dart';

class ForgotPasswordMain extends StatelessWidget {
  const ForgotPasswordMain({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Set your base design size
      minTextAdapt: true,
      builder: (_, __) => MaterialApp(
        home: Scaffold(
          extendBody: true,
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: Text(
              'Forgot your password',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22.sp,
                color: AppColors.pinkIconBack,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Text(
                  'Hello there!',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Enter your email address. We will send a code verification in the next step.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13.sp,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(color: Colors.white, fontSize: 14.sp),
                    ),
                    SizedBox(height: 10.h),
                    SizedBox(
                      width: 357.w,
                      height: 40.h,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'example@example.com',
                          hintStyle: TextStyle(fontSize: 14.sp),
                          filled: true,
                          fillColor: AppColors.pinkIcon.withOpacity(0.9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                BottomContinueButton(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

