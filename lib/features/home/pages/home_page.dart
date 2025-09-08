import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_exam/features/trend-recipes/managers/trending_page_view_model.dart';
import 'package:flutter_exam/features/home/pages/search_delegate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../../bottomPages/pages/app_bar_bottom_pages.dart';
import '../../chefs/managers/top_chefs_view_model.dart';
import '../../trend-recipes/managers/trend_recipes_view_model.dart';
import '../../bottomPages/managers/appbar_bottom_view_model.dart';
import '../managers/recent_recipes_view_model.dart';
import '../../profile/managers/my_recipes_view_model.dart';
import '../widgets/home_page_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = Hive.box('user_account');
  bool isHeartRed = false;
  int _selectedIndex = 0;

  void toggleHeartColor() {
    setState(() {
      isHeartRed = !isHeartRed;
    });
  }

  final List<String> _images = [
    'assets/icons/home.svg',
    'assets/icons/community.svg',
    'assets/icons/big-tick.svg',
    'assets/icons/profile.svg',
  ];

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TrendRecipesVM()..fetchTrendRecipes(),
        ),
        ChangeNotifierProvider(create: (_) => AppbarBottomVM()..fetchAppBar()),
        ChangeNotifierProvider(
          create: (_) => RecentRecipesVM()..fetchRecentRecipes(),
        ),
        ChangeNotifierProvider(create: (_) => TrendingRecipesVM()),
        ChangeNotifierProvider(create: (_) => MyRecipesVM()..fetchMyRecipes()),
        ChangeNotifierProvider(create: (_) => TopChefsVM()..fetchChefs()),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi! ${box.get('fullName')}',
                style: TextStyle(
                  color: AppColors.pinkIconBack,
                  fontWeight: FontWeight.w400,
                  fontSize: 25.sp,
                ),
              ),
              Text(
                'What are you cooking today',
                style: TextStyle(
                  color: const Color(0xFFFFFDF9),
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(5),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.pinkIcon,
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: IconButton(
                onPressed: () {
                  context.go('/notification_main');
                },
                icon: Icon(Icons.notifications_none, color: Colors.white),
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.all(5),
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: AppColors.pinkIcon,
                borderRadius: BorderRadiusGeometry.circular(16),
              ),
              child: IconButton(
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
                icon: Icon(Icons.search, color: Colors.white),
              ),
            ),
            SizedBox(width: 8.w),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: Consumer<AppbarBottomVM>(
              builder: (context, vm, child) {
                if (vm.isLoading) {
                  return const SizedBox(
                    height: 60,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (vm.error != null) {
                  return SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        vm.error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                }

                if (vm.appBarBottomList.isEmpty) {
                  return const SizedBox(
                    height: 60,
                    child: Center(
                      child: Text(
                        "No categories",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }

                return SizedBox(
                  height: 60.h,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    itemCount: vm.appBarBottomList.length,
                    separatorBuilder: (_, __) => SizedBox(width: 10.w),
                    itemBuilder: (context, index) {
                      final category = vm.appBarBottomList[index];
                      final bool isSelected = vm.selectedCategory == category.title;

                      return GestureDetector(
                        onTap: () {
                          vm.updateSelectedCategory(category.title);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AppbarBottomPages(
                                categoryTitle: category.title,
                                recipes: context.read<TrendRecipesVM>().trendRecipes,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: 85.w,
                          margin: EdgeInsets.only(top: 15.h),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.red : Colors.transparent,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.pinkIconBack,
                              width: 1.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            category.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppColors.pinkIconBack,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 15.h),
                  Container(
                    margin: EdgeInsets.only(right: 200.w),
                    child: Text(
                      'Trending Recipes',
                      style: TextStyle(
                        color: AppColors.pinkIconBack,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  // TRENDING RECIPES BOSHLANISHI
                  GestureDetector(
                    onTap: () {
                      context.go('/trendingRecipes');
                    },
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 30.w, right: 10.w),
                          width: 358.w,
                          height: 143.h,
                          child: Consumer<TrendRecipesVM>(
                            builder: (context, vm, child) {
                              if (vm.isLoading) {
                                return const CircularProgressIndicator();
                              }
                              if (vm.trendRecipes.isEmpty) {
                                return const Text("No trending");
                              }
                              final recipe = vm.trendRecipes.isNotEmpty
                                  ? vm.trendRecipes[0]
                                  : null;
                              if (recipe == null) {
                                return const Text("No recipe data");
                              }
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(20.r),
                                child: Image.network(
                                  recipe.TrendingRecipesImage,
                                  width: 358.w,
                                  height: 143.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Text("Image failed to load");
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                        Positioned(
                          top: 10.h,
                          right: 10.w,
                          child: GestureDetector(
                            onTap: toggleHeartColor,
                            child: Container(
                              padding: EdgeInsets.all(6.r),
                              width: 28.w,
                              height: 28.h,
                              decoration: BoxDecoration(
                                color: isHeartRed
                                    ? Colors.red
                                    : AppColors.pinkIconBack,
                                borderRadius: BorderRadius.circular(100.r),
                              ),
                              child: SvgPicture.asset(
                                'assets/icons/heart.svg',
                                width: 10.w,
                                height: 15.h,
                                color: isHeartRed ? Colors.white : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 30.w, right: 10.w),
                    padding: EdgeInsets.only(left: 10.w, top: 10.h),
                    width: 348.w,
                    height: 69.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.pinkIconBack),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Consumer<TrendRecipesVM>(
                            builder: (context, vm, child) {
                              final recipe = vm.trendRecipes.isNotEmpty
                                  ? vm.trendRecipes[0]
                                  : null;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    vm.trendRecipes.isNotEmpty
                                        ? recipe!.TrendingRecipesTitle
                                        : '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 260.w,
                                    child: Text(
                                      vm.trendRecipes.isNotEmpty
                                          ? recipe!.TrendingRecipesDescription
                                          : '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Consumer<TrendRecipesVM>(
                              builder: (context, vm, child) {
                                final recipe = vm.trendRecipes.isNotEmpty
                                    ? vm.trendRecipes[0]
                                    : null;
                                return Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/clock.svg',
                                      width: 10.w,
                                      height: 15.h,
                                      color: AppColors.pinkIconBack,
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      vm.trendRecipes.isNotEmpty
                                          ? recipe!.TrendingRecipesTime
                                                .toString()
                                          : '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.pinkIconBack,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            SizedBox(height: 5.h),
                            Consumer<TrendRecipesVM>(
                              builder: (context, vm, child) {
                                final recipe = vm.trendRecipes.isNotEmpty
                                    ? vm.trendRecipes[0]
                                    : null;
                                return Row(
                                  children: [
                                    Text(
                                      vm.trendRecipes.isNotEmpty
                                          ? recipe!.TrendingRecipesRating
                                                .toString()
                                          : '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.pinkIconBack,
                                      ),
                                    ),
                                    SizedBox(width: 4.w),
                                    SvgPicture.asset(
                                      'assets/icons/star.svg',
                                      width: 10.w,
                                      height: 15.h,
                                      color: AppColors.pinkIconBack,
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),

                  // TRENDING RECIPES OXIRI

                  // YOUR RECIPES BOSHLANISHI
                  Consumer<MyRecipesVM>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (vm.error != null) {
                        return Center(
                          child: Text(
                            vm.error!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (vm.myRecipesList.isEmpty) {
                        return const Center(
                          child: Text(
                            "No recipes found",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 12.h,
                          horizontal: 8.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.pinkIconBack,
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: 8.0.w,
                                bottom: 8.h,
                              ),
                              child: Text(
                                'Your Recipes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 200.h,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 12,
                                      crossAxisSpacing: 12,
                                      childAspectRatio: 3 / 4,
                                    ),
                                itemCount: vm.myRecipesList.length,
                                itemBuilder: (context, index) {
                                  final recipe = vm.myRecipesList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.go('/yourRecipes');
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            children: [
                                              SizedBox(
                                                width: 168.w,
                                                height: 162.h,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(
                                                              16.r,
                                                            ),
                                                        topRight:
                                                            Radius.circular(
                                                              16.r,
                                                            ),
                                                      ),
                                                  child: Image.network(
                                                    recipe.photo,
                                                    height: 120.h,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: 8.h,
                                                right: 8.w,
                                                child: Container(
                                                  padding: EdgeInsets.all(6.r),
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/heart.svg',
                                                    width: 12.w,
                                                    height: 12.h,
                                                    color:
                                                        AppColors.pinkIconBack,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: 168.w,
                                            height: 68.h,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  recipe.title,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        recipe.rating
                                                            .toString(),
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .pinkIconBack,
                                                        ),
                                                      ),
                                                      SvgPicture.asset(
                                                        'assets/icons/star.svg',
                                                        width: 10.w,
                                                        height: 10.h,
                                                        color: AppColors
                                                            .pinkIconBack,
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      SvgPicture.asset(
                                                        'assets/icons/clock.svg',
                                                        width: 10.w,
                                                        height: 10.h,
                                                        color: AppColors
                                                            .pinkIconBack,
                                                      ),
                                                      SizedBox(width: 4.w),
                                                      Text(
                                                        "${recipe.timeRequired}min",
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: AppColors
                                                              .pinkIconBack,
                                                        ),
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
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 15.h),
                  Container(
                    padding: EdgeInsets.only(left: 30.w, top: 10.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Chefs',
                          style: TextStyle(
                            color: AppColors.pinkIconBack,
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Consumer<TopChefsVM>(
                          builder: (context, vm, child) {
                            if (vm.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              );
                            }
                            if (vm.error != null) {
                              return Center(
                                child: Text(
                                  vm.error!,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              );
                            }
                            return SizedBox(
                              height: 100.h,
                              child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                    ),
                                itemCount: vm.topChefsList.length,
                                itemBuilder: (context, index) {
                                  final chef = vm.topChefsList[index];
                                  return GestureDetector(
                                    onTap: () {
                                      context.go('/chefs');
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: 82.w,
                                          height: 74.h,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              20.r,
                                            ),
                                            child: Image.network(chef.photo),
                                          ),
                                        ),
                                        Text(
                                          chef.name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.sp,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    'Recently Added',
                    style: TextStyle(
                      color: AppColors.pinkIconBack,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Consumer<RecentRecipesVM>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        );
                      }
                      if (vm.error != null) {
                        return Center(
                          child: Text(
                            vm.error!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      return SizedBox(
                        height: 100.h,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                          itemCount: vm.recentRecipesList.length,
                          itemBuilder: (context, index) {
                            final recipe = vm.recentRecipesList[index];
                            return GestureDetector(
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Clicked on Recently Added Image',
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          20.r,
                                        ),
                                        child: Image.network(
                                          recipe.photo,
                                          width: 168.w,
                                          height: 162.h,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 8.h,
                                        right: 8.w,
                                        child: SvgPicture.asset(
                                          'assets/icons/heart.svg',
                                          width: 20.w,
                                          height: 20.h,
                                          color: AppColors.pinkIconBack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
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
      ),
    );
  }
}
