import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../colors.dart';
import '../trend-recipes/managers/trend_recipes_view_model.dart';

class CuisinePreferencePage extends StatefulWidget {
  const CuisinePreferencePage({super.key});

  @override
  State<CuisinePreferencePage> createState() => _CuisinePreferencePageState();
}

class _CuisinePreferencePageState extends State<CuisinePreferencePage> {
  final List<String> selectedCuisines = [];

  void toggleCuisine(String title) {
    setState(() {
      if (selectedCuisines.contains(title)) {
        selectedCuisines.remove(title);
      } else {
        selectedCuisines.add(title);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendRecipesVM()..fetchTrendRecipes(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(12),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(100),
                ),
                alignment: Alignment.center,
                child: FractionallySizedBox(
                  widthFactor: 0.50, // step 2/4 progress
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.pinkIconBack,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Select your cuisines preferences',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please select your cuisines preferences for better recommendations or you can skip it.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Consumer<TrendRecipesVM>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (vm.error != null) {
                        return Center(
                          child: Text(
                            'Error: ${vm.error}',
                            style: const TextStyle(color: Colors.redAccent),
                          ),
                        );
                      }
                      if (vm.trendRecipes.isEmpty) {
                        return const Center(
                          child: Text(
                            'No cuisines available',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.only(top: 8),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: vm.trendRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = vm.trendRecipes[index];
                          final isSelected =
                          selectedCuisines.contains(recipe.TrendingRecipesTitle);

                          return GestureDetector(
                            onTap: () => toggleCuisine(recipe.TrendingRecipesTitle),
                            child: Column(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? AppColors.pinkIconBack
                                          : Colors.transparent,
                                      width: 2,
                                    ),
                                    image: DecorationImage(
                                      image: NetworkImage(recipe.TrendingRecipesImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  recipe.TrendingRecipesTitle,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.pinkIconBack
                                        : Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.go('/logIn'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 76),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Skip',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        context.go('/allergy');
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 60),
                        decoration: BoxDecoration(
                          color: AppColors.pinkIconBack,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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
    );
  }
}
