import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_exam/features/home/managers/trend_recipes_view_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class OnBoardingLastPage extends StatelessWidget {
  const OnBoardingLastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TrendRecipesVM(),
      builder: (context, child) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: AppColors.backgroundColor,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Grid of trending recipes
                Expanded(
                  child: Consumer<TrendRecipesVM>(
                    builder: (context, vm, child) {
                      if (vm.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (vm.error != null) {
                        return Center(child: Text('Error: ${vm.error}'));
                      }
                      if (vm.trendRecipes.isEmpty) {
                        return const Center(child: Text('No data'));
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.only(bottom: 16),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 1, // square look like screenshot
                        ),
                        itemCount: vm.trendRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = vm.trendRecipes[index];
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              recipe.TrendingRecipesImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: Colors.grey[300],
                                    child: const Icon(Icons.error,
                                        color: Colors.red),
                                  ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Bottom Section (Welcome + buttons)
                const SizedBox(height: 8),
                const Text(
                  'Welcome',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Find the best recipes that the world can provide you\n'
                      'also with every step that you can learn to increase\n'
                      'your cooking skills.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Buttons stacked
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.pinkIcon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      context.go('/cooking_level');
                    },
                    child: const Text(
                      'I\'m New',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: AppColors.pinkIcon,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    onPressed: () {
                      context.go('/logIn');
                    },
                    child: const Text(
                      'I\'ve Been Here',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
