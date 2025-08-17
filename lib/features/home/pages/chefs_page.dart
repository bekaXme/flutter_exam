import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../managers/chefs_view_model.dart';
import '../../../data/models/chefs_model.dart';

class ChefsPage extends StatelessWidget {
  const ChefsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChefsViewModel(),
      child: Consumer<ChefsViewModel>(
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
                      onPressed: vm.retryFetch,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              backgroundColor: const Color(0xFF1B1A1F),
            );
          }

          return Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory(
                    title: "Most Viewed Chefs",
                    chefs: vm.chefsList.take(2).toList(),
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
                          Expanded(child: Container(
                            child: Column(
                              children: [
                                _buildChefCard(vm.chefsList[2]),
                                ],
                            ),
                          ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: Container(
                            child: Column(
                              children: [
                                _buildChefCard(vm.chefsList[3]),
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
                          Expanded(child: Container(
                            child: Column(
                              children: [
                                _buildChefCard(vm.chefsList[5]),
                              ],
                            ),
                          ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(child: Container(
                            child: Column(
                              children: [
                                _buildChefCard(vm.chefsList[4]),
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
            bottomNavigationBar: _buildBottomNav(),
          );
        },
      ),
    );
  }

  Widget _buildCategory({required String title, required List<ChefsModel> chefs}) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF5B5B), // same pink/red background for all categories
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
                  child: _buildChefCard(chef),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildChefCard(ChefsModel chef) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // card inside is white to match your screenshot
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              chef.chefPhoto,
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
                  "${chef.chefSurname} ${chef.chefName}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "@${chef.chefUsername}",
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.favorite, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    const Text(
                      "6687", // static placeholder
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
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2A2A33),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.pinkAccent,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
      ],
    );
  }
}
