import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../colors.dart';

class ShareProfilePage extends StatefulWidget {
  const ShareProfilePage({super.key});

  @override
  State<ShareProfilePage> createState() => _ShareProfilePageState();
}

class _ShareProfilePageState extends State<ShareProfilePage> {
  late Box _userBox;

  @override
  void initState() {
    super.initState();
    _userBox = Hive.box('user_account');
  }

  @override
  Widget build(BuildContext context) {
    final name = _userBox.get('name', defaultValue: 'Guest');
    final username = _userBox.get('username', defaultValue: 'username');
    final bio = _userBox.get('bio', defaultValue: 'No bio');
    final link = _userBox.get('link', defaultValue: 'https://example.com');

    // Text to encode in QR (customize as needed)
    final qrData = '''
Name: $name
Username: @$username
Bio: $bio
Link: $link
''';

    return Scaffold(
      backgroundColor: AppColors.pinkIconBack,
      appBar: AppBar(
        leading: Container(
          width: 30.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: IconButton(
            onPressed: () {
              context.go('/myProfile');
            },
            icon: SvgPicture.asset(
              'assets/icons/back-arrow.svg',
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.pinkIconBack,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 220.0,
              backgroundColor: Colors.white,
            ),
            SizedBox(height: 30.h),

            Container(
              width: 200.w,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Center(
                child: Text(
                  'Share Profile',
                  style: TextStyle(
                    color: AppColors.pinkIconBack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            Opacity(
              opacity: 0.6,
              child: Container(
                width: 200.w,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    'Copy Link',
                    style: TextStyle(
                      color: AppColors.pinkIconBack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 12.h),

            Opacity(
              opacity: 0.6,
              child: Container(
                width: 200.w,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Center(
                  child: Text(
                    'More Options',
                    style: TextStyle(
                      color: AppColors.pinkIconBack,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
