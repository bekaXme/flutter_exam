import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_exam/colors.dart';

import '../widgets/bottom_continue_button.dart';

class GettingOTP extends StatefulWidget {
  const GettingOTP({super.key});

  @override
  State<GettingOTP> createState() => _GettingOTPState();
}

class _GettingOTPState extends State<GettingOTP> {
  int seconds = 10;
  late final Timer timer;
  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick >= 10) {
        timer.cancel();
      }
      seconds--;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Text(
          'Forgot your password',
          style: TextStyle(
            color: AppColors.pinkIconBack,
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You’ve got mail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'We sent a verification code to your email address. Please check your inbox and enter the code below.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 40.h),
            Form(
              key: formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 38.w,
                    height: 38.h,
                    child: TextFormField(
                      controller: controllers[index],
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.pinkIconBack),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.pinkIconBack),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.pinkIconBack),
                          borderRadius: BorderRadius.circular(18.r),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 5) {
                          FocusScope.of(context).nextFocus();
                        } else if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 40.h),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        'Didn’t receive a code?',
                        style: TextStyle(color: Colors.white, fontSize: 13.sp),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'You can resend it in',
                          children: [
                            TextSpan(text: '  '),
                            TextSpan(
                              text: seconds.toString(),
                              style: TextStyle(
                                color: AppColors.pinkIconBack,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 100.w,
                    height: 30.h,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        disabledBackgroundColor: Colors.grey,
                        disabledForegroundColor: Colors.white,
                      ),
                      onPressed: seconds == 0 ? () {
                        setState(() {
                          seconds = 10;
                          timer.cancel();
                          timer = Timer.periodic(Duration(seconds: 1), (timer) {
                            if (timer.tick >= 10) {
                              timer.cancel();
                            }
                            seconds--;
                            setState(() {});
                          });
                        });
                      } : null,
                      child: Text(
                        'Resend',
                        style: TextStyle(
                          color: AppColors.pinkIconBack,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            BottomContinueButton(routerLocation: '/home'),
          ],
        ),
      ),
    );
  }
}
