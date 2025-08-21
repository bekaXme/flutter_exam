import 'package:flutter/material.dart';
import 'package:flutter_exam/features/home/pages/chef_account_page.dart';
import 'package:flutter_exam/features/home/pages/chefs_page.dart';
import 'package:flutter_exam/features/home/pages/trending_recipes.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_exam/colors.dart';
import '../../features/auth/pages/forgot_password_main.dart';
import '../../features/auth/pages/gettingOTP.dart';
import '../../features/auth/pages/log_in.dart';
import '../../features/auth/pages/sign_up.dart';
import '../../features/home/pages/cooking_level/allergy_meals.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/home/pages/onboarding/onboarding_main.dart';

final GoRouter router = GoRouter(
  initialLocation: '/chef_account',
  routes: [
    GoRoute(
      path: '/home',
      name: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/chef_account',
      name: 'chef_account',
      builder: (context, state) {
        return ChefAccountPage();
      },
    ),
    GoRoute(
      path: '/chefs',
      name: '/chefs',
      builder: (context, state) => const ChefsPage(),
    ),
    GoRoute(
      path: '/OnBoardingMain',
      name: '/OnBoardingMain',
      builder: (context, state) => GetInspiredPage(),
    ),
    GoRoute(
      path: '/trendingRecipes',
      builder: (context, state) => const TrendingRecipes(),
    ),
    GoRoute(
      path: '/getOTP',
      name: '/getOTP',
      builder: (context, state) => GettingOTP(),
    ),
    GoRoute(
      path: '/forgotPassword',
      name: '/forgotPassword',
      builder: (context, state) => const ForgotPasswordMain(),
    ),
    GoRoute(
      path: '/definition',
      name: '/definition',
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: Container(
              padding: EdgeInsets.only(right: 170),
              width: 232,
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusGeometry.circular(100),
              ),
              child: Container(
                width: 65,
                height: 12,
                decoration: BoxDecoration(
                  color: AppColors.pinkIconBack,
                  borderRadius: BorderRadiusGeometry.circular(100),
                ),
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const Text(
                  '¿What is your cooking level?',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please select your cooking level for better recommendations.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                const LoremWidget(
                  title: 'Novice',
                  subtitle:
                      'You’re just getting started in the kitchen and learning basic recipes.',
                ),
                const SizedBox(height: 30),
                const LoremWidget(
                  title: 'Intermediate',
                  subtitle:
                      'You can follow most recipes and understand some cooking techniques.',
                ),
                const SizedBox(height: 30),
                const LoremWidget(
                  title: 'Advanced',
                  subtitle:
                      'You’re confident in the kitchen and enjoy experimenting with complex dishes.',
                ),
                const SizedBox(height: 30),
                const LoremWidget(
                  title: 'Expert',
                  subtitle:
                      'You could cook with your eyes closed. You’re a culinary master!',
                ),
                const SizedBox(height: 30),
                Center(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color(0xFFFD5D69),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 56,
                        vertical: 11,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      context.go('/home');
                    },
                    child: const Text(
                      'Continue',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: '/allergy',
      name: '/allergy',
      builder: (context, state) => const AllergyPageView(),
    ),
    GoRoute(
      path: '/logIn',
      name: '/logIn',
      builder: (context, state) => LogIn(),
    ),
    GoRoute(
      path: '/signUp',
      name: '/signUp',
      builder: (context, state) => SignUp(),
    ),
  ],
);

class LoremWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const LoremWidget({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        width: 356,
        height: 116,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
