import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../managers/reviews_view_model.dart';
import '../../../colors.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({super.key});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  final Set<int> favoriteReviews = {};

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewsVM()..fetchMyReviews(),
      child: Consumer<ReviewsVM>(
        builder: (context, vm, child) {
          print('Reviewer List: ${vm.reviewerList}'); // Debug
          if (vm.isMyReviewsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.myReviewsError != null) {
            return Center(child: Text(vm.myReviewsError!));
          }
          if (vm.reviewerList.isEmpty) {
            return const Center(child: Text('No reviews available'));
          }

          final review = vm.reviewerList[0];
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  semanticsLabel: 'Back',
                  placeholderBuilder: (context) => const Icon(Icons.arrow_back),
                ),
              ),
              title: const Text(
                'Reviews',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.pinkIconBack,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  color: AppColors.pinkIconBack,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(14.r),
                        child: CachedNetworkImage(
                          imageUrl: review.productPhoto,
                          width: 162.w,
                          height: 163.h,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => const Center(child: Text('Failed to load image')),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  color: index < review.rating ? Colors.white : Colors.grey,
                                  size: 16.w,
                                ),
                              ),
                            ),
                            Text(
                              '(${review.reviewsCount} Reviews)',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14.r),
                                  child: CachedNetworkImage(
                                    imageUrl: review.reviewerPhoto,
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Center(child: Text('Failed to load image')),
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '@${review.reviewerUserName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                    Text(
                                      '${review.firstName} ${review.lastName}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 8.h),
                            ElevatedButton(
                              onPressed: () {
                                context.go('/leaveReview');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              ),
                              child: const Text(
                                'Add Review',
                                style: TextStyle(color: AppColors.pinkIconBack),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final reviewId = review.reviewId;
                                  if (favoriteReviews.contains(reviewId)) {
                                    favoriteReviews.remove(reviewId);
                                  } else {
                                    favoriteReviews.add(reviewId);
                                  }
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(5.w),
                                width: 35.w,
                                height: 35.h,
                                decoration: BoxDecoration(
                                  color: favoriteReviews.contains(review.reviewId) ? Colors.red : Colors.white,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: SvgPicture.asset(
                                  'assets/icons/heart.svg',
                                  color: favoriteReviews.contains(review.reviewId) ? Colors.white : Colors.red,
                                  semanticsLabel: 'Favorite',
                                  placeholderBuilder: (context) => const Icon(Icons.favorite_border),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: const Text(
                    'Comments',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: vm.reviewerList.length,
                    itemBuilder: (context, index) {
                      final item = vm.reviewerList[index];
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(20.r),
                          child: CachedNetworkImage(
                            imageUrl: item.reviewerPhoto,
                            width: 40.w,
                            height: 40.h,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => const Center(child: Text('Failed to load image')),
                          ),
                        ),
                        title: Text(
                          '@${item.reviewerUserName}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.reviewerComment,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                    (i) => Icon(
                                  Icons.star,
                                  color: i < item.rating ? Colors.yellow : Colors.grey,
                                  size: 16.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${index == 0 ? '15 Mins Ago' : index == 1 ? '40 Mins Ago' : '1 Hr Ago'}',
                              style: const TextStyle(color: Colors.white70),
                            ),
                            SizedBox(width: 8.w),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  final reviewId = item.reviewId;
                                  if (favoriteReviews.contains(reviewId)) {
                                    favoriteReviews.remove(reviewId);
                                  } else {
                                    favoriteReviews.add(reviewId);
                                  }
                                });
                              },
                              child: SvgPicture.asset(
                                'assets/icons/heart.svg',
                                color: favoriteReviews.contains(item.reviewId) ? Colors.red : Colors.grey,
                                width: 20.w,
                                height: 20.h,
                                semanticsLabel: 'Favorite',
                                placeholderBuilder: (context) => const Icon(Icons.favorite_border),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
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
                          icon: SvgPicture.asset(
                            'assets/icons/home.svg',
                            semanticsLabel: 'Home',
                            placeholderBuilder: (context) => const Icon(Icons.home),
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.go('/community'),
                          icon: SvgPicture.asset(
                            'assets/icons/community.svg',
                            semanticsLabel: 'Community',
                            placeholderBuilder: (context) => const Icon(Icons.group),
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.go('/categories'),
                          icon: SvgPicture.asset(
                            'assets/icons/categories.svg',
                            semanticsLabel: 'Categories',
                            placeholderBuilder: (context) => const Icon(Icons.category),
                          ),
                        ),
                        IconButton(
                          onPressed: () => context.go('/profile'),
                          icon: SvgPicture.asset(
                            'assets/icons/profile.svg',
                            semanticsLabel: 'Profile',
                            placeholderBuilder: (context) => const Icon(Icons.person),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}