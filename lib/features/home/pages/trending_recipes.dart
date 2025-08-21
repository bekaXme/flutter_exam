import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../colors.dart';
import '../managers/trending_page_view_model.dart';
import '../managers/trending_recipes_item_view_model.dart';

class TrendingRecipes extends StatelessWidget {
  const TrendingRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TrendingRecipesVM()..fetchTrendingRecipes(),
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
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
        body: Consumer<TrendingRecipesVM>(
          builder: (context, vm, child) {
            if (vm.trendingRecipesList.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Container(
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
                                      vm.trendingRecipesList[0].photo,
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
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
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
                                            vm.trendingRecipesList[0].title,
                                            style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            vm
                                                .trendingRecipesList[0]
                                                .description,
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
