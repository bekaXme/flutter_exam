import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors.dart';
import '../managers/your_recipes_view_model.dart';

class YourRecipesPage extends StatelessWidget {
  const YourRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => YourRecipesVM()..fetchMyRecipes(),
      child: Consumer<YourRecipesVM>(
        builder: (context, vm, child) {
          if (vm.isMyRecipesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.myRecipesError != null) {
            return Center(child: Text(vm.myRecipesError!));
          }
          if (vm.yourRecipesList.isEmpty) {
            return const Center(child: Text('No recipes available'));
          }

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              leading: Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: () => context.pop(),
                  child: SvgPicture.asset(
                    'assets/icons/back-arrow.svg',
                    semanticsLabel: 'Back',
                    placeholderBuilder: (context) => const Icon(Icons.arrow_back),
                  ),
                ),
              ),
              title: const Text(
                'Your Recipes',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.pinkIconBack,
                ),
              ),
              centerTitle: true,
              actions: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.pinkIconBack,
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 8),
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    semanticsLabel: 'Notification',
                    placeholderBuilder: (context) => const Icon(Icons.notifications),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: AppColors.pinkIconBack,
                  ),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(right: 12),
                  child: SvgPicture.asset(
                    'assets/icons/search.svg',
                    semanticsLabel: 'Search',
                    placeholderBuilder: (context) => const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Most Viewed Today Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.pinkIconBack,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Most Viewed Today',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: vm.yourRecipesList.length > 2 ? 2 : vm.yourRecipesList.length,
                            itemBuilder: (context, index) {
                              final item = vm.yourRecipesList[index];
                              return GestureDetector(
                                onTap: () => context.go('/recipeDetail/${item.id}?isYourRecipe=true'),
                                child: Container(
                                  width: 160,
                                  margin: const EdgeInsets.only(right: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                        child: CachedNetworkImage(
                                          imageUrl: item.productImage ?? 'https://via.placeholder.com/100',
                                          height: 100,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.productName ?? 'Unnamed Recipe',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                color: Colors.black,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Row(
                                              children: [
                                                const Icon(Icons.star, size: 14, color: Colors.orange),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${item.rating ?? 0.0}",
                                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                                                ),
                                                const SizedBox(width: 8),
                                                const Icon(Icons.access_time, size: 14, color: Colors.black54),
                                                const SizedBox(width: 4),
                                                Text(
                                                  "${item.timeRequired ?? 0} min",
                                                  style: const TextStyle(fontSize: 12, color: Colors.black54),
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Other Recipes Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: vm.yourRecipesList.length,
                      itemBuilder: (context, index) {
                        final item = vm.yourRecipesList[index];
                        return GestureDetector(
                          onTap: () => context.go('/recipeDetail/${item.id}?isYourRecipe=true'),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                      child: CachedNetworkImage(
                                        imageUrl: item.productImage ?? 'https://via.placeholder.com/120',
                                        height: 120,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error),
                                      ),
                                    ),
                                    Positioned(
                                      top: 8,
                                      right: 8,
                                      child: SvgPicture.asset(
                                        'assets/icons/heart.svg',
                                        width: 20,
                                        height: 20,
                                        placeholderBuilder: (context) => const Icon(Icons.favorite_border),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    item.productName ?? 'Unnamed Recipe',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
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
            ),
          );
        },
      ),
    );
  }
}