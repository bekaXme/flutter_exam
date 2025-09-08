import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors.dart';
import '../managers/trend_recipes_view_model.dart';

class TrendingItemPage extends StatelessWidget {
  final String recipeId;

  const TrendingItemPage({super.key, required this.recipeId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendRecipesVM()..fetchTrendRecipes(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => context.go('/trendingRecipes'),
            icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
          ),
          title: const Text(
            "Trending Recipes",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: AppColors.pinkIconBack,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/heart.svg'),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/share.svg'),
            ),
          ],
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
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/categories.svg'),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/profile.svg'),
                ),
              ],
            ),
          ),
        ),

        body: Consumer<TrendRecipesVM>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }

            final recipe = vm.trendRecipes.firstWhere(
              (r) => r.recipeId.toString() == recipeId,
              orElse: () => throw Exception("Recipe not found"),
            );

            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 80),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            recipe.TrendingRecipesImage,
                            width: double.infinity,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 100),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: SvgPicture.asset(
                              'assets/icons/play.svg',
                              color: AppColors.pinkIconBack,
                              width: 28,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            height: 55,
                            decoration: const BoxDecoration(
                              color: AppColors.pinkIconBack,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    recipe.TrendingRecipesTitle,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/star.svg",
                                      color: Colors.white,
                                      width: 16,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      recipe
                                          .TrendingRecipesRating.toStringAsFixed(
                                        1,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () {
                                        context.go('/leaveReview');
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.comment,
                                            color: Colors.white,
                                            size: 18,
                                          ),
                                          const SizedBox(width: 5),
                                          const Text(
                                            "30",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          recipe.user.profilePhoto ?? "",
                        ),
                      ),
                      title: Text(
                        "@${recipe.user.username}",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: AppColors.pinkIconBack,
                        ),
                      ),
                      subtitle: Text(
                        "${recipe.user.username}-Chef",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.pinkIcon,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text(
                          "Following",
                          style: TextStyle(color: AppColors.pinkIconBack),
                        ),
                      ),
                    ),

                    const SizedBox(height: 15),

                    // Details Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          const Text(
                            "Details",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.pinkIconBack,
                            ),
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            "assets/icons/clock.svg",
                            width: 18,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            "${recipe.TrendingRecipesTime.toInt()} min",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        recipe.TrendingRecipesDescription,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    // Ingredients Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: const Text(
                        "Ingredients",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.pinkIconBack,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("• 1 pre-made pizza dough", style: TextStyle(color: Colors.white)),
                          Text("• 1/2 cup pizza sauce", style: TextStyle(color: Colors.white)),
                          Text("• 1/2 cup shredded mozzarella cheese", style: TextStyle(color: Colors.white)),
                          Text("• 1/4 cup sliced salami", style: TextStyle(color: Colors.white)),
                          Text("• Fresh basil leaves", style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
