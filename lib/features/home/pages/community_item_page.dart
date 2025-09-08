import 'package:flutter/material.dart';
import 'package:flutter_exam/features/home/pages/search_delegate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/colors.dart';
import '../managers/community_view_model.dart';

class CommunityItemPage extends StatelessWidget {
  final int recipeId;
  const CommunityItemPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
          onPressed: () => context.go('/home'),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Community',
          style: TextStyle(color: AppColors.pinkIconBack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/notification_main');
            },
            icon: const Icon(
              Icons.notifications,
              color: AppColors.pinkIconBack,
            ),
          ),
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                builder: (context) => const CustomSearchSheet(),
              );
            },
            icon: const Icon(Icons.search, color: AppColors.pinkIconBack),
          ),
        ],
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Consumer<CommunityMainVM>(
        builder: (context, communityVM, child) {
          final recipe = communityVM.communityList.firstWhere(
                (r) => r.id == recipeId,
            orElse: () => communityVM.communityList.first,
          );

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.network(
                      recipe.productPhoto,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 280,
                    ),
                    Positioned.fill(
                      child: Center(
                        child: IconButton(
                          icon: const Icon(Icons.play_circle_fill,
                              size: 64, color: Colors.pink),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),

                // 🔹 Title + stats
                Container(
                  color: AppColors.pinkIconBack,
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        recipe.productTitle,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                          Text('${recipe.rating}',
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(width: 12),
                          const Icon(Icons.favorite, color: Colors.white, size: 18),
                          const SizedBox(width: 4),
                        ],
                      )
                    ],
                  ),
                ),

                // 🔹 User info
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(recipe.userPhoto),
                  ),
                  title: Text(
                    "@${recipe.userName}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    "${recipe.userName}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.pinkIconBack,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () {},
                    child: const Text("Following",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const Divider(color: Colors.grey),

                // 🔹 Details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.white),
                      const SizedBox(width: 6),
                      Text(
                        "${recipe.timeRequired} min",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    recipe.productDescription,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ),

                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                // 🔹 Example static ingredients
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("• 1 lb chicken breast",
                          style: TextStyle(color: Colors.grey)),
                      Text("• 1 onion",
                          style: TextStyle(color: Colors.grey)),
                      Text("• 2 cloves garlic",
                          style: TextStyle(color: Colors.grey)),
                      Text("• 1 tsp curry powder",
                          style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
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
