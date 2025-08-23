import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../managers/reviews_view_model.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReviewsVM()..fetchMyReviews(), // Trigger fetch on init
      child: Consumer<ReviewsVM>(
        builder: (context, vm, child) {
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
              leading: SvgPicture.asset('assets/icons/back-arrow.svg'),
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
                  padding: const EdgeInsets.all(16),
                  color: AppColors.pinkIconBack,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          review.productPhoto,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),
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
                            ),
                            Row(
                              children: List.generate(
                                5,
                                    (index) => Icon(
                                  Icons.star,
                                  color: index < review.rating ? Colors.yellow : Colors.grey,
                                  size: 16,
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
                            Text(
                              '@${review.reviewerUserName} ${review.firstName} ${review.lastName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
                              child: const Text('Add Review', style: TextStyle(color: AppColors.pinkIconBack)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
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
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(item.reviewerPhoto, width: 40, height: 40, fit: BoxFit.cover),
                        ),
                        title: Text('@${item.reviewerUserName}', style: const TextStyle(color: Colors.white)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.reviewerComment, style: const TextStyle(color: Colors.white70)),
                            Row(
                              children: List.generate(
                                5,
                                    (i) => Icon(
                                  Icons.star,
                                  color: i < item.rating ? Colors.yellow : Colors.grey,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        trailing: Text('${index == 0 ? '15 Mins Ago' : index == 1 ? '40 Mins Ago' : '1 Hr Ago'}',
                            style: const TextStyle(color: Colors.white70)),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: AppColors.pinkIconBack,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SvgPicture.asset('assets/icons/home.svg'),
                      SvgPicture.asset('assets/icons/chat.svg'),
                      SvgPicture.asset('assets/icons/layers.svg'),
                      const Icon(Icons.circle, color: Colors.white, size: 8),
                    ],
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