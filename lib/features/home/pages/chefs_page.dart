import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../managers/top_chefs_view_model.dart';
import '../../../data/models/top_chefs_model.dart';

class ChefsPage extends StatelessWidget {
  const ChefsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopChefsVM(),
      child: Consumer<TopChefsVM>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          if (vm.error != null) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(vm.error!, style: const TextStyle(color: Colors.white)),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: vm.fetchChefs,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color(0xFF1B1A1F),
            );
          }

          if (vm.topChefsList.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text(
                  "No chefs found",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              backgroundColor: const Color(0xFF1B1A1F),
            );
          }

          return Scaffold(
            extendBody: true,
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  context.go('/home');
                },
                icon: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                ),
              ),
              title: const Text("Top Chef"),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    'assets/icons/notification.svg',
                  ),
                ),
              ],
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              foregroundColor: Colors.white,
            ),
            body: Builder(
              builder: (innerContext) => SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategory(
                      title: "Most Viewed Chefs",
                      chefs: vm.topChefsList.take(2).toList(),
                      context: innerContext,
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Most Liked Chefs",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pinkIconBack,
                          ),
                        ),
                        Row(
                          children: [
                            if (vm.topChefsList.length > 2)
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      _buildChefCard(vm.topChefsList[2], innerContext),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(width: 16),
                            if (vm.topChefsList.length > 3)
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      _buildChefCard(vm.topChefsList[3], innerContext),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Chefs",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.pinkIconBack,
                          ),
                        ),
                        Row(
                          children: [
                            if (vm.topChefsList.length > 5)
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      _buildChefCard(vm.topChefsList[5], innerContext),
                                    ],
                                  ),
                                ),
                              ),
                            const SizedBox(width: 16),
                            if (vm.topChefsList.length > 4)
                              Expanded(
                                child: Container(
                                  child: Column(
                                    children: [
                                      _buildChefCard(vm.topChefsList[4], innerContext),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
          );
        },
      ),
    );
  }

  Widget _buildCategory({
    required String title,
    required List<TopChefsModel> chefs,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5B5B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: chefs.map((chef) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: _buildChefCard(chef, context),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChefCard(TopChefsModel chef, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go('/chef_account', extra: chef.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                chef.photo,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 120,
                  color: Colors.grey,
                  child: const Icon(Icons.error, color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${chef.name} ${chef.name}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    "@${chef.name}",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.favorite, color: Colors.red, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        "6687",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFF5B5B),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                          ),
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
    );
  }
}