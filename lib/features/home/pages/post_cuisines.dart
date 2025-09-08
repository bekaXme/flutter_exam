import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../managers/post_cuisines_vm.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CuisineVM(),
      child: Consumer<CuisineVM>(
        builder: (context, vm, _) {
          return Scaffold(
            extendBody: true,
            backgroundColor: const Color(0xFF1B0C0C),
            // dark background
            appBar: AppBar(
              backgroundColor: const Color(0xFF1B0C0C),
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
                  icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
                ),
              ),
              elevation: 0,
              title: const Text(
                "Create Recipe",
                style: TextStyle(color: AppColors.pinkIconBack),
              ),
              centerTitle: true,
              bottom: PreferredSize(
                preferredSize: Size(double.infinity, 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 141.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: AppColors.pinkIcon,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Publish Recipes',
                                    style: TextStyle(
                                      color: AppColors.pinkIconBack,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Are you sure you want to publish recipe?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 141.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.pinkIcon,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 141.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.pinkIconBack,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Publish",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }, // publish logic
                        child: const Text(
                          "Publish",
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                    Container(
                      width: 141.w,
                      height: 26.h,
                      decoration: BoxDecoration(
                        color: AppColors.pinkIcon,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Delete Recipes',
                                    style: TextStyle(
                                      color: AppColors.pinkIconBack,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Are you sure you want to delete recipe?',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(height: 16.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 141.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.pinkIcon,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 141.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          color: AppColors.pinkIconBack,
                                          borderRadius: BorderRadius.circular(
                                            12.r,
                                          ),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Delete",
                          style: TextStyle(color: Colors.pinkAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Video Upload Placeholder
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  TextField(
                    controller: vm.titleController,
                    decoration: _inputDecoration("Recipe Title"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  TextField(
                    controller: vm.descriptionController,
                    decoration: _inputDecoration("Recipe Description"),
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),

                  // Time Recipe
                  TextField(
                    controller: vm.timeController,
                    decoration: _inputDecoration("Time: 30 min"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),

                  // Ingredients
                  const Text(
                    "Ingredients",
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                  const SizedBox(height: 8),
                  const SizedBox(height: 20),
                  // Instructions
                  const Text(
                    "Instructions",
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
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
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF2A1C1C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
