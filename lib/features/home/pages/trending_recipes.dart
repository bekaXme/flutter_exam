import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../colors.dart';
import '../managers/trending_page_view_model.dart';

class TrendingRecipes extends StatelessWidget {
  const TrendingRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendingRecipesVM()..fetchTrendingRecipes(),
      builder: (context, state) {
        return Consumer<TrendingRecipesVM>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (vm.error != null) {
              return Center(child: Text(vm.error!));
            }
            if (vm.trendingRecipesList.isEmpty) {
              return const Center(child: Text('No trending recipes available'));
            }

            return Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundColor,
                leading: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset('assets/icons/back.svg'),
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
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 260, // Adjusted height to fit content
                            decoration: BoxDecoration(
                              color: AppColors.pinkIconBack,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'most viewed today',
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
                                        vm.trendingRecipesList[0].photo,
                                        width: double.infinity,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return const Center(
                                            child: Text('Failed to load image'),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 10,
                                      child: Container(
                                        width: 28,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(100),
                                        ),
                                        child: SvgPicture.asset(
                                          'assets/icons/heart.svg',
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
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              vm.trendingRecipesList[0].title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              vm.trendingRecipesList[0].description,
                                              style: const TextStyle(fontSize: 10),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
                                                  '${vm.trendingRecipesList[0].timeRequired} min',
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
                                                  '${vm.trendingRecipesList[0].rating}',
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
                          Container(
                            height: 300,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                crossAxisCount: 1,
                                childAspectRatio: 1.2,
                              ),
                              itemCount: vm.trendingRecipesList.length > 5
                                  ? 5
                                  : vm.trendingRecipesList.length, // ✅ Dynamic count
                              itemBuilder: (context, index) {
                                final recipe = vm.trendingRecipesList[index];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            recipe.photo,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Center(child: Text('Failed to load image'));
                                            },
                                          ),
                                        ),
                                        Positioned(
                                          top: 5,
                                          right: 5,
                                          child: Container(
                                            width: 20,
                                            height: 20,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.circular(100),
                                            ),
                                            child: SvgPicture.asset(
                                              'assets/icons/heart.svg',
                                              width: 16,
                                              height: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 100,
                                        padding: const EdgeInsets.only(left: 10),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              recipe.title,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            Text(
                                              recipe.description,
                                              style: const TextStyle(fontSize: 10),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  'assets/icons/clock.svg',
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${recipe.timeRequired} min',
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Text(
                                                  recipe.difficulty,
                                                  style: const TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                SvgPicture.asset(
                                                  'assets/icons/star.svg',
                                                  width: 16,
                                                  height: 16,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  '${recipe.rating}',
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
                                    ),
                                  ],
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}