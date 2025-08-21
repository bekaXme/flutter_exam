import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../data/models/chef_account_model.dart';
import '../managers/chef_account_view_model.dart';

class ChefAccountPage extends StatelessWidget {
  const ChefAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChefAccountVM(),
      child: Consumer<ChefAccountVM>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              elevation: 0,
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                  'assets/icons/back-arrow.svg',
                  width: 24,   // ✅ corrected width
                  height: 24,  // ✅ corrected height
                ),
              ),
              title: vm.isLoading
                  ? const Text("Chef", style: TextStyle(color: Colors.white))
                  : Text(
                "@${vm.chefAccountList.isNotEmpty ? vm.chefAccountList[0].username : "Chef"}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.pinkIconBack,
                ),
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 44, // ✅ fixed consistent width
                  height: 44, // ✅ fixed consistent height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: AppColors.pinkIconBack,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.share, color: AppColors.pinkIcon, size: 22),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return _bottomSheet(vm);
                        },
                      );
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  width: 44, // ✅ fixed consistent width
                  height: 44, // ✅ fixed consistent height
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(56),
                    color: AppColors.pinkIconBack,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white, size: 22),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16),
                          ),
                        ),
                        builder: (context) {
                          return _secondBottomSheet(vm);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            body: vm.isLoading
                ? const Center(child: CircularProgressIndicator())
                : vm.chefAccountList.isEmpty
                ? const Center(
              child: Text(
                "No chef data found",
                style: TextStyle(color: Colors.white),
              ),
            )
                : _buildProfile(context, vm.chefAccountList[0]),
            bottomNavigationBar: Container(
              margin: const EdgeInsets.only(bottom: 36, left: 76, right: 76),
              decoration: BoxDecoration(
                color: AppColors.pinkIconBack,
                borderRadius: BorderRadius.circular(
                  23
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/home.svg', color: Colors.white,),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/community.svg', color: Colors.white,),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/categories.svg', color: Colors.white,),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/profile.svg', color: Colors.white,),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, ChefAccountModel chef) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 45, // ✅ reduced to fit better
                backgroundImage: NetworkImage(chef.profilePhoto),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${chef.firstName} ${chef.lastName}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.pinkIconBack,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Passionate chef in creative and contemporary cuisine.',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.grey[400]),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 100, // ✅ fixed width
                      height: 32, // ✅ fixed height
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: AppColors.pinkIcon,
                          foregroundColor: AppColors.pinkIconBack,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Following',
                          style: TextStyle(fontSize: 13),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Stats
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: 70, // ✅ slightly taller for balance
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade700),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _statItem("15", "Recipes"),
                _divider(),
                _statItem("256,770", "Followers"),
                _divider(),
                _statItem("255,770", "Following"),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Recipes (mock UI, replace with real list later)
          Column(
            children: [
              _recipeCard(
                "Vegan Recipes",
                "https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600",
              ),
              const SizedBox(height: 12),
              _recipeCard(
                "Asian Heritage",
                "https://images.unsplash.com/photo-1543353071-873f17a7a088?w=600",
              ),
              const SizedBox(height: 12),
              _recipeCard(
                "Guilty Pleasures",
                "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=600",
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
      ],
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 30,
      color: Colors.grey.shade600,
    );
  }

  Widget _recipeCard(String title, String imageUrl) {
    return Container(
      height: 140, // ✅ increased height for better visibility
      width: double.infinity, // ✅ full width card
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.5), Colors.transparent],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _bottomSheet(ChefAccountVM vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  vm.chefAccountList[0].profilePhoto,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '@${vm.chefAccountList[0].username}',
                style: const TextStyle(color: AppColors.pinkIconBack),
              ),
            ],
          ),
          ListTile(title: const Text("Manage notifications"), onTap: () {}),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text("Mute notifications"),
          ),
          SwitchListTile(
            value: true,
            onChanged: (val) {},
            title: const Text("Mute account"),
          ),
          SwitchListTile(
            value: false,
            onChanged: (val) {},
            title: const Text("Block account"),
          ),
          ListTile(
            leading: const Icon(Icons.report),
            title: const Text("Report"),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _secondBottomSheet(ChefAccountVM vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(
                  vm.chefAccountList[0].profilePhoto,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '@${vm.chefAccountList[0].username}',
                style: const TextStyle(color: AppColors.pinkIconBack),
              ),
            ],
          ),
          ListTile(title: const Text("Copy Profile URL"), onTap: () {}),
          ListTile(title: const Text("Share this Profile"), onTap: () {}),
        ],
      ),
    );
  }
}
