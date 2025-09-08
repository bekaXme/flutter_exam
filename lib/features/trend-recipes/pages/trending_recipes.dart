import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../../colors.dart';
import '../../home/widgets/rich_text.dart';
import '../managers/trend_recipes_view_model.dart';

class TrendingRecipes extends StatefulWidget {
  TrendingRecipes({super.key});

  @override
  State<TrendingRecipes> createState() => _TrendingRecipesState();
}

class _TrendingRecipesState extends State<TrendingRecipes> {
  late Box<String> favoritesBox;
  final Set<int> favoriteRecipes = {};

  @override
  void initState() {
    super.initState();
    favoritesBox = Hive.box<String>('favorites');

    // Load existing favorites from Hive
    favoriteRecipes.addAll(
      favoritesBox.values.map((id) => int.parse(id)).toSet(),
    );
  }

  void toggleFavorite(int recipeId) {
    setState(() {
      if (favoriteRecipes.contains(recipeId)) {
        favoriteRecipes.remove(recipeId);
        favoritesBox.delete(recipeId.toString());
      } else {
        favoriteRecipes.add(recipeId);
        favoritesBox.put(recipeId.toString(), recipeId.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TrendRecipesVM()..fetchTrendRecipes(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
            onPressed: () => context.go('/home'),
            icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
          ),
          title: Text(
            'Trending Recipes',
            style: TextStyle(
              color: AppColors.pinkIconBack,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/search.svg'),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/filter.svg'),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: Consumer<TrendRecipesVM>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }
            if (vm.trendRecipes.isEmpty) {
              return const Center(child: Text('No trending recipes available'));
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        // Most Viewed Recipe
                        GestureDetector(
                          onTap: () {
                            print(vm.trendRecipes[0].recipeId);
                            // context.go(
                            //   '/recipeDetail/${vm.trendRecipes[0].user.id}',
                            // );
                          },
                          child: Container(
                            width: double.infinity,
                            height: 252,
                            decoration: BoxDecoration(
                              color: AppColors.pinkIconBack,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Most viewed today',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        vm.trendRecipes[0].TrendingRecipesImage,
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Center(
                                            child: Text(
                                              'Failed to load image',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: GestureDetector(
                                        onTap: () => toggleFavorite(
                                          vm.trendRecipes[0].recipeId,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                            BorderRadius.circular(100),
                                          ),
                                          child: SvgPicture.asset(
                                            'assets/icons/heart.svg',
                                            color: favoriteRecipes.contains(
                                              vm.trendRecipes[0].recipeId,
                                            )
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20),
                                      bottomLeft: Radius.circular(20),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              vm.trendRecipes[0]
                                                  .TrendingRecipesTitle,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              vm.trendRecipes[0]
                                                  .TrendingRecipesDescription,
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/clock.svg',
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${vm.trendRecipes[0].TrendingRecipesTime.toInt()} min',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  vm.trendRecipes[0]
                                                      .TrendingRecipesRating
                                                      .toStringAsFixed(1),
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: AppColors.pinkIconBack,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // List of All Trending Recipes
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: vm.trendRecipes.length,
                          itemBuilder: (context, index) {
                            final recipe = vm.trendRecipes[index];
                            return GestureDetector(
                              onTap: () {
                                print(recipe.recipeId);
                                context.go(
                                  '/recipeDetail/${vm.trendRecipes[index].recipeId}',
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          child: Image.network(
                                            recipe.TrendingRecipesImage,
                                            width: 150,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: GestureDetector(
                                            onTap: () =>
                                                toggleFavorite(recipe.recipeId),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              width: 35,
                                              height: 35,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(20),
                                              ),
                                              child: SvgPicture.asset(
                                                'assets/icons/heart.svg',
                                                width: 14,
                                                height: 14,
                                                color: favoriteRecipes.contains(
                                                  recipe.recipeId,
                                                )
                                                    ? Colors.red
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      width: 207,
                                      height: 122,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(12),
                                          bottomRight: Radius.circular(12),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            recipe.TrendingRecipesTitle,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          ExpandableText(
                                            text: recipe
                                                .TrendingRecipesDescription,
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                            trimLines: 2,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/clock.svg',
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    '${recipe.TrendingRecipesTime.toInt()} min',
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: AppColors
                                                          .pinkIconBack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/icons/star.svg',
                                                  ),
                                                  const SizedBox(width: 5),
                                                  Text(
                                                    recipe
                                                        .TrendingRecipesRating
                                                        .toStringAsFixed(1),
                                                    style: const TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
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
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/home.svg'),
                ),
                IconButton(
                  onPressed: () {},
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
      ),
    );
  }
}
