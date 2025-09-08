import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_exam/features/home/pages/search_delegate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../managers/community_view_model.dart';

class CommunityUsersPage extends StatefulWidget {
  const CommunityUsersPage({super.key});

  @override
  State<CommunityUsersPage> createState() => _CommunityUsersPageState();
}

class _CommunityUsersPageState extends State<CommunityUsersPage>
    with SingleTickerProviderStateMixin {
  List<String> appbarBottomTitles = ['Top Recipes', 'Newest', 'Oldest'];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: appbarBottomTitles.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CommunityMainVM()..fetchCommunityData(),
      child: Scaffold(
        extendBody: true,
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: IconButton(
            icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
            onPressed: () => context.go('/home'),
          ),
          backgroundColor: AppColors.backgroundColor,
          title: const Text(
            'Community',
            style: TextStyle(color: AppColors.pinkIconBack),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.go('/notification_main');
              },
              icon: const Icon(Icons.notifications, color: AppColors.pinkIconBack),
            ),
            IconButton(
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
              icon: const Icon(Icons.search, color: AppColors.pinkIconBack),
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            indicatorColor: AppColors.pinkIconBack,
            tabs: appbarBottomTitles
                .map((title) => Tab(child: Text(title, style: const TextStyle(color: Colors.white))))
                .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: appbarBottomTitles.map((title) {
            return Consumer<CommunityMainVM>(
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
                final filteredList = switch (title) {
                  'Top Recipes' => communityVM.communityList
                    ..sort((a, b) => b.rating.compareTo(a.rating)),
                  'Newest' => communityVM.communityList
                    ..sort((a, b) => b.date.compareTo(a.date)),
                  'Oldest' => communityVM.communityList
                    ..sort((a, b) => a.date.compareTo(b.date)),
                  _ => communityVM.communityList,
                };

                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final recipe = filteredList[index];

                    return GestureDetector(
                      onTap: () {
                        context.goNamed('community-item',
                            pathParameters: {'id': '${recipe.id}'});
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
                              title: Text(recipe.userName,
                                  style: const TextStyle(color: Colors.white)),
                              subtitle: Text(
                                recipe.date.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: const Icon(Icons.favorite_border,
                                  color: Colors.pink),
                            ),
                            Image.network(
                              recipe.productPhoto,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image,
                                  color: Colors.white),
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
                              padding:
                              const EdgeInsets.symmetric(horizontal: 8.0),
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
                                    style:
                                    const TextStyle(color: Colors.white),
                                  ),
                                  const Spacer(),
                                  Icon(Icons.star, color: Colors.pink[200]),
                                  const SizedBox(width: 5),
                                  Text(
                                    '${recipe.rating}',
                                    style:
                                    const TextStyle(color: Colors.white),
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
            );
          }).toList(),
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
