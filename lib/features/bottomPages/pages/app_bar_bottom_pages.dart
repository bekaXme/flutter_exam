import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../colors.dart';
import '../../../../data/models/trend_recipes_model.dart';

class AppbarBottomPages extends StatefulWidget {
  final String categoryTitle;
  final List<TrendRecipesModel> recipes;

  const AppbarBottomPages({
    super.key,
    required this.categoryTitle,
    required this.recipes,
  });

  @override
  State<AppbarBottomPages> createState() => _AppbarBottomPagesState();
}

class _AppbarBottomPagesState extends State<AppbarBottomPages> {
  final Set<int> favoriteRecipes = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.go('/home'),
          icon: SvgPicture.asset(
            'assets/icons/back-arrow.svg',
            semanticsLabel: 'Back',
            placeholderBuilder: (context) => const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: Text(
          widget.categoryTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            color: AppColors.pinkIconBack,
          ),
        ),
        centerTitle: true,
      ),
      body: widget.recipes.isEmpty
          ? Center(
        child: Text(
          "No recipes available",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      )
          : GridView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        itemCount: widget.recipes.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.w,
          mainAxisSpacing: 12.h,
          childAspectRatio: 0.75, // Adjusted to fit content better
        ),
        itemBuilder: (context, index) {
          final recipe = widget.recipes[index];
          return GestureDetector(
            onTap: () {
              context.go('/recipeDetail/${recipe.recipeId}?isYourRecipe=false');
            },
            child: Card(
              color: Colors.white.withOpacity(0.1), // Subtle background
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: 220.h, // Limit height to prevent overflow
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: recipe.TrendingRecipesImage,
                            height: 120.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.broken_image, color: Colors.white70),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  recipe.TrendingRecipesTitle,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4.h),
                                Flexible(
                                  child: Text(
                                    recipe.TrendingRecipesDescription,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.white70,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/star.svg',
                                          width: 14.w,
                                          height: 14.h,
                                          color: Colors.amber,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          recipe.TrendingRecipesRating.toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/clock.svg',
                                          width: 14.w,
                                          height: 14.h,
                                          color: Colors.pinkAccent,
                                        ),
                                        SizedBox(width: 3.w),
                                        Text(
                                          "${recipe.TrendingRecipesTime.toInt()} min",
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Heart button
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (favoriteRecipes.contains(recipe.recipeId)) {
                              favoriteRecipes.remove(recipe.recipeId);
                            } else {
                              favoriteRecipes.add(recipe.recipeId);
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: favoriteRecipes.contains(recipe.recipeId)
                                ? Colors.red
                                : Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/heart.svg',
                            width: 14.w,
                            height: 14.h,
                            color: favoriteRecipes.contains(recipe.recipeId)
                                ? Colors.white
                                : Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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