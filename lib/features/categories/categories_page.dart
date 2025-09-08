import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../bottomPages/app_bar_bottom_pages.dart';
import '../home/managers/appbar_bottom_view_model.dart';
import '../home/managers/trend_recipes_view_model.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AppbarBottomVM()..fetchAppBar()),
      ChangeNotifierProvider(create: (_) => TrendRecipesVM()),
    ],
        child: Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        leading: IconButton(
          onPressed: () {
            context.go('/home');
          },
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
        ),
        title: const Text(
          'Categories',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.go('/notifications');
            },
            icon: const Icon(Icons.notification_add_outlined,
                color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              context.go('/search');
            },
            icon: SvgPicture.asset('assets/icons/search.svg'),
          ),
        ],
      ),
      body: Consumer<AppbarBottomVM>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          final categories = vm.appBarBottomList.take(6).toList(); // 👈 только 6

          return GridView.builder(
            padding: EdgeInsets.all(16.w),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.h,
              crossAxisSpacing: 20.w,
              childAspectRatio: 0.9,
            ),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AppbarBottomPages(
                        categoryTitle: category.title,
                        recipes: context.read<TrendRecipesVM>().trendRecipes,
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Image.network(
                        category.imageUrl ?? '',
                        width: 150.w,
                        height: 120.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      category.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 36.h, left: 60.w, right: 60.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Container(
          width: 280.w,
          height: 60.h,
          decoration: BoxDecoration(
            color: AppColors.pinkIconBack,
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () => context.go('/home'),
                icon: SvgPicture.asset('assets/icons/home.svg'),
              ),
              IconButton(
                onPressed: () => context.go('/community'),
                icon: SvgPicture.asset('assets/icons/community.svg'),
              ),
              IconButton(
                onPressed: () => context.go('/categories'),
                icon: SvgPicture.asset('assets/icons/categories.svg'),
              ),
              IconButton(
                onPressed: () => context.go('/profile'),
                icon: SvgPicture.asset('assets/icons/profile.svg'),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}

