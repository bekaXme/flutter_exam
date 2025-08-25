import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../managers/appbar_bottom_view_model.dart';
import '../managers/community_view_model.dart';

class CommunityUsersPage extends StatelessWidget {
  const CommunityUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppbarBottomVM()..fetchAppBar()),
        ChangeNotifierProvider(
          create: (_) => CommunityMainVM()..fetchCommunityData(),
        ),
      ],
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(60.0),
            child: Consumer<AppbarBottomVM>(
              builder: (context, appBarVM, child) {
                if (appBarVM.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (appBarVM.error != null) {
                  return Center(
                    child: Text(
                      'Error: ${appBarVM.error}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: appBarVM.appBarBottomList.map((category) {
                      return GestureDetector(
                        onTap: () {
                          appBarVM.updateSelectedCategory(category.title);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Chip(
                            label: Text(
                              category.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor:
                                appBarVM.selectedCategory == category.title
                                ? Colors.pink[400]
                                : Colors.pink[200],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            ),
          ),
        ),
        body: Consumer<CommunityMainVM>(
          builder: (context, communityVM, child) {
            if (communityVM.isCommunityLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (communityVM.communityError != null) {
              return Center(
                child: Text(
                  'Error: ${communityVM.communityError}',
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            if (communityVM.communityList.isEmpty) {
              return const Center(
                child: Text(
                  'No recipes available',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return ListView.builder(
              itemCount: communityVM.communityList.length,
              itemBuilder: (context, index) {
                final recipe = communityVM.communityList[index];

                return GestureDetector(
                  onTap: () {
                    context.goNamed('community-item', pathParameters: {'id': '${recipe.id}'});
                  },
                  child: Card(
                    color: AppColors.pinkIconBack,
                    margin: const EdgeInsets.all(8.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(recipe.userPhoto),
                          ),
                          title: Text(
                            recipe.userName,
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            recipe.date.toString(),
                            style: const TextStyle(color: Colors.grey),
                          ),
                          trailing: Icon(
                            Icons.favorite_border,
                            color: Colors.pink,
                          ),
                        ),
                        Image.network(
                          recipe.productPhoto,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 200,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(
                                Icons.broken_image,
                                color: Colors.white,
                              ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recipe.productTitle,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            recipe.productDescription,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.timer, color: Colors.pink[200]),
                              const SizedBox(width: 5),
                              Text(
                                '${recipe.timeRequired} min',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const Spacer(),
                              Icon(Icons.star, color: Colors.pink[200]),
                              const SizedBox(width: 5),
                              Text(
                                '${recipe.rating}',
                                style: const TextStyle(color: Colors.white),
                              ),
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
      ),
    );
  }
}
