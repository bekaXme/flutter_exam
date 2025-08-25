import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'Community',
          style: TextStyle(color: AppColors.pinkIconBack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications,
              color: AppColors.pinkIconBack,
            ),
          ),
          IconButton(
            onPressed: () {},
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
        margin: EdgeInsets.only(bottom: 40, left: 70, right: 70),
        decoration: BoxDecoration(
          color: AppColors.pinkIconBack,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/home.svg',
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/categories.svg',
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/community.svg',
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/profile.svg',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
