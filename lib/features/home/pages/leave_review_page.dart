import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_exam/features/home/managers/reviews_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LeaveReviewPage extends StatelessWidget {
  const LeaveReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewsVM(),
      child: Consumer<ReviewsVM>(
        builder: (context, vm, child) {
          return Scaffold(
            extendBody: true,
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  width: 15,
                  height: 14,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: const Text(
                'Leave A Review',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.pinkIconBack,
                ),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Product Image + Title
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.network(
                          vm.reviewerList.isNotEmpty
                              ? vm.reviewerList[0].productPhoto
                              : "https://via.placeholder.com/300",
                          height: 220,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(14),
                                bottomRight: Radius.circular(14)),
                            color: AppColors.pinkIconBack,
                          ),
                          child: Text(
                            vm.reviewerList.isNotEmpty
                                ? vm.reviewerList[0].productName
                                : "Product Name",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Star Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      5,
                          (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(
                          Icons.star,
                          color: index < 3
                              ? AppColors.pinkIconBack
                              : Colors.white24,
                          size: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Your overall rating",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 24),

                  // Review Text Field
                  TextField(
                    maxLines: 5,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Leave us Review!",
                      hintStyle: const TextStyle(color: Colors.white54),
                      filled: true,
                      fillColor: AppColors.pinkIconBack.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Add Photo
                  Row(
                    children: [
                      const Icon(Icons.add_a_photo,
                          color: AppColors.pinkIconBack),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Add Photo",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Recommend radio buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Do you recommend this recipe?",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Row(
                        children: const [
                          Text("No", style: TextStyle(color: Colors.white)),
                          SizedBox(width: 4),
                          Icon(Icons.cancel, color: AppColors.pinkIconBack),
                          SizedBox(width: 16),
                          Text("Yes", style: TextStyle(color: Colors.white)),
                          SizedBox(width: 4),
                          Icon(Icons.favorite, color: AppColors.pinkIconBack),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Cancel & Submit Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            AppColors.pinkIconBack.withOpacity(0.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.pinkIconBack,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: AppColors.backgroundColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Thank you for your Review!',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 16),
                                      const Icon(
                                        Icons.done_outline_sharp,
                                        color: AppColors.pinkIconBack,
                                        size: 60,
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        'Lorem ipsum dolor sit amet pretium cras id dui pellentesque ornare.',
                                        style: TextStyle(color: Colors.white70),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 24),
                                      TextButton(
                                        onPressed: () {
                                          context.go('/home');
                                        },
                                        child: const Text(
                                          'Go To Home',
                                          style: TextStyle(
                                            color: AppColors.pinkIconBack,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 32),
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
}
