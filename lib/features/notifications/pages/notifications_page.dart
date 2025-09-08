import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../widgets/notification_widget.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        "title": "Weekly New Recipes!",
        "description": "Discover our new recipes of the week!"
      },
      {
        "title": "Update Available",
        "description": "A new version of the app is ready to download."
      },
      {
        "title": "Cooking Reminder",
        "description": "Don't forget your cooking challenge today!"
      },
      {
        "title": "New Follower",
        "description": "John Doe started following you."
      },
      {
        "title": "Recipe Liked",
        "description": "Your pasta recipe got 120 new likes!"
      },
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            width: 20.w,
            height: 20.h,
          ),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.pinkIconBack,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(16.w),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return NotificationTemplate(
            title: n["title"]!,
            description: n["description"]!,
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
          ),
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Container(
          width: 280.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: const Color(0xFFFD5D69),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  context.go('/home');
                },
                icon: SvgPicture.asset('assets/icons/home.svg'),
              ),
              IconButton(
                onPressed: () {
                  context.go('/community');
                },
                icon: SvgPicture.asset('assets/icons/community.svg'),
              ),
              IconButton(
                onPressed: () {
                  context.go('/categoriesPage');
                },
                icon: SvgPicture.asset('assets/icons/categories.svg'),
              ),
              IconButton(
                onPressed: () {
                  context.go('/myProfile');
                },
                icon: SvgPicture.asset('assets/icons/profile.svg'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

