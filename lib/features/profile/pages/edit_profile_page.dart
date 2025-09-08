import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';

import '../../../colors.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final box = Hive.box('user_account');

  late TextEditingController _nameController;
  late TextEditingController _usernameController;
  late TextEditingController _bioController;
  late TextEditingController _linkController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: box.get('name', defaultValue: ''));
    _usernameController = TextEditingController(text: box.get('username', defaultValue: ''));
    _bioController = TextEditingController(text: box.get('bio', defaultValue: ''));
    _linkController = TextEditingController(text: box.get('link', defaultValue: ''));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    box.put('name', _nameController.text.trim());
    box.put('username', _usernameController.text.trim());
    box.put('bio', _bioController.text.trim());
    box.put('link', _linkController.text.trim());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          "Profile Updated",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Your profile has been successfully updated.",
          style: TextStyle(fontSize: 14.sp),
        ),
        actions: [
          TextButton(
            onPressed: () => context.go('/myProfile'),
            child: Text("OK", style: TextStyle(color: AppColors.pinkIconBack, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.white54, fontSize: 14.sp),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.r),
        borderSide: BorderSide.none,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: GestureDetector(
          onTap: () => context.go('/myProfile'),
          child: Container(
            padding: EdgeInsets.all(5.w),
            width: 30.w,
            height: 30.h,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SvgPicture.asset('assets/icons/back-arrow.svg'),
          ),
        ),
        title: Text(
          'Edit Profile',
          style: TextStyle(
            color: AppColors.pinkIconBack,
            fontWeight: FontWeight.w500,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage: const AssetImage('assets/images/profile.png'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Change photo',
                      style: TextStyle(color: AppColors.pinkIconBack, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text('Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _nameController,
              decoration: _inputDecoration(box.get('name', defaultValue: '')),
            ),
            SizedBox(height: 16.h),
            Text('Username', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _usernameController,
              decoration: _inputDecoration(box.get('username', defaultValue: '')),
            ),
            SizedBox(height: 16.h),
            Text('Presentation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _bioController,
              maxLines: 3,
              decoration: _inputDecoration(box.get('bio', defaultValue: '')),
            ),
            SizedBox(height: 16.h),
            Text('Add link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15.sp)),
            SizedBox(height: 6.h),
            TextField(
              controller: _linkController,
              decoration: _inputDecoration(box.get('link', defaultValue: '')),
            ),
            SizedBox(height: 24.h),
            Center(
              child: SizedBox(
                width: 152.w,
                height: 45.h,
                child: ElevatedButton(
                  onPressed: _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.pinkIconBack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                  ),
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 16.sp, color: Colors.white),
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
