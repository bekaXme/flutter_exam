import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ChefAccountPage extends StatelessWidget {
  const ChefAccountPage({super.key});

  void _showActions1(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/200/200?chef1",
                  ),
                ),
                title: const Text(
                  "@neil_tran",
                  style: TextStyle(color: AppColors.pinkIcon),
                ),
              ),
              const Divider(color: Colors.white24),
              SwitchListTile(
                value: true,
                onChanged: (_) {},
                title: const Text(
                  "Manage notifications",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SwitchListTile(
                value: false,
                onChanged: (_) {},
                title: const Text(
                  "Mute notifications",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              ListTile(
                title: const Text(
                  "Block Account",
                  style: TextStyle(color: Colors.black),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Report",
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  void _showActions2(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/200/200?chef2",
                  ),
                ),
                title: const Text(
                  "@neil_tran",
                  style: TextStyle(color: AppColors.pinkIconBack),
                ),
              ),
              const Divider(color: Colors.white24),
              ListTile(
                title: const Text(
                  "Copy Profile URL",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  "Share this Profile",
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go('/chefs'),
          icon: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: const Text(
          "@Neil_tran",
          style: TextStyle(color: AppColors.pinkIconBack),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _showActions1(context),
            icon: const Icon(Icons.settings, color: Colors.white),
          ),
          IconButton(
            onPressed: () => _showActions2(context),
            icon: const Icon(Icons.more_vert, color: Colors.white),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    "https://picsum.photos/200/200?profile",
                  ), // random img
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Neil Tran - Chef",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Professional Chef",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _StatWidget(label: "Posts", value: "128"),
                _StatWidget(label: "Followers", value: "256.7K"),
                _StatWidget(label: "Following", value: "356"),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _RecipeCard(
                    title: "Vegan Recipes",
                    imgUrl: "https://picsum.photos/400/200?1",
                  ),
                  _RecipeCard(
                    title: "Asian Heritage",
                    imgUrl: "https://picsum.photos/400/200?2",
                  ),
                  _RecipeCard(
                    title: "Guilty Pleasures",
                    imgUrl: "https://picsum.photos/400/200?3",
                  ),
                ],
              ),
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
    );
  }
}

class _StatWidget extends StatelessWidget {
  final String label;
  final String value;

  const _StatWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}

class _RecipeCard extends StatelessWidget {
  final String title;
  final String imgUrl;

  const _RecipeCard({required this.title, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.hardEdge,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imgUrl,
            height: 150,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
