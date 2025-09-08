import 'package:flutter/material.dart';
import 'package:flutter_exam/features/categories/pages/categories_page.dart';
import 'package:flutter_exam/features/cooking_level/cuisine_preference_page.dart';
import 'package:flutter_exam/features/cooking_level/interative_profile_page.dart';
import 'package:flutter_exam/features/chefs/pages/chef_account_page.dart';
import 'package:flutter_exam/features/home/pages/leave_review_page.dart';
import 'package:flutter_exam/features/home/pages/reviews_page.dart';
import 'package:flutter_exam/features/home/pages/settings_profile.dart';
import 'package:flutter_exam/features/trend-recipes/pages/trending_recipes.dart';
import 'package:flutter_exam/features/home/pages/your_recipes.dart';
import 'package:flutter_exam/features/onboarding/pages/onboarding_improve.dart';
import 'package:flutter_exam/features/onboarding/pages/onboarting_end_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/pages/forgot_password_main.dart';
import '../../features/auth/pages/gettingOTP.dart';
import '../../features/auth/pages/log_in.dart';
import '../../features/auth/pages/sign_up.dart';
import '../../features/chefs/pages/chefs_page.dart';
import '../../features/community/pages/community_item_page.dart';
import '../../features/community/pages/community_page.dart';
import '../../features/following/pages/follower_page.dart';
import '../../features/home/pages/cooking_level/allergy_meals.dart';
import '../../features/home/pages/home_page.dart';
import '../../features/profile/pages/edit_profile_page.dart';
import '../../features/profile/pages/my_profile.dart';
import '../../features/onboarding/pages/onboarding_page.dart';
import '../../features/home/pages/post_cuisines.dart';
import '../../features/notifications/pages/notifications_page.dart';
import '../../features/onboarding/pages/onboarding_main.dart';
import '../../features/profile/pages/share_profile.dart';
import '../../features/trend-recipes/pages/trending_recipes_item.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Used
    GoRoute(
      path: '/home',
      name: '/home',
      builder: (context, state) => const HomePage(),
    ),
    // Used
    GoRoute(
      path: '/onboardinglastPage',
      name: '/onboardinglastPage',
      builder: (context, state) => const OnBoardingLastPage(),
    ),
    // Used
    GoRoute(
      path: '/onboarding_second',
      name: '/onboarding_second',
      builder: (context, state) => const OnBoardingImprove(),
    ),
    // Used
    GoRoute(
      path: '/preference_page',
      name: '/preference_page',
      builder: (context, state) => const CuisinePreferencePage(),
    ),
    // Used
    GoRoute(
      path: '/cooking_level',
      name: '/cooking_level',
      builder: (context, state) => const InterativeProfilePage(),
    ),
    GoRoute(
      path: '/follow_page',
      name: '/follow_page',
      builder: (context, state) => FollowerPage(),
    ),
    GoRoute(
      path: '/community',
      name: '/community',
      builder: (context, state) => const CommunityUsersPage(),
    ),
    GoRoute(
      path: '/myProfile',
      builder: (context, state) => const MyProfilePage(),
    ),
    GoRoute(
      path: '/community/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return CommunityItemPage(recipeId: id);
      },
    ),
    // Used
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/chef_account',
      builder: (context, state) {
        final chefId = state.extra as int?;
        return ChefAccountPage();
      },
    ),
    GoRoute(
      path: '/notification_main',
      builder: (context, state) => const NotificationsPage(),
    ),
    GoRoute(
      path: '/chefs',
      name: '/chefs',
      builder: (context, state) => const ChefsPage(),
    ),
    GoRoute(
      path: '/yourRecipes',
      name: '/yourRecipes',
      builder: (context, state) => const YourRecipesPage(),
    ),
    GoRoute(
      path: '/leaveReview',
      name: '/leaveReview',
      builder: (context, state) => const LeaveReviewPage(),
    ),
    GoRoute(
      path: '/categoriesPage',
      name: '/categoriesPage',
      builder: (context, state) => const CategoriesPage(),
    ),
    GoRoute(
      path: '/reviews',
      name: '/reviews',
      builder: (context, state) => const ReviewsPage(),
    ),
    // Used
    GoRoute(
      path: '/trendingRecipes',
      builder: (context, state) => TrendingRecipes(),
    ),
    // Used
    GoRoute(
      path: '/recipe/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TrendingItemPage(recipeId: id);
      },
    ),
    GoRoute(
      path: '/recipeDetail/:recipeId',
      builder: (context, state) {
        final recipeId = state.pathParameters['recipeId']!;
        return TrendingItemPage(recipeId: recipeId);
      },
    ),
    GoRoute(
      path: '/cuisinePost',
      builder: (context, state) => const CreateRecipePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
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
    // Used
    GoRoute(
      path: '/allergy',
      name: '/allergy',
      builder: (context, state) => const AllergyPageView(),
    ),
    // Used
    GoRoute(
      path: '/logIn',
      name: '/logIn',
      builder: (context, state) => LoginPage(),
    ),
    // Used
    GoRoute(
      path: '/shareProfile',
      name: '/shareProfile',
      builder: (context, state) => ShareProfilePage(),
    ),
    // Used
    GoRoute(
      path: '/editProfile',
      name: '/editProfile',
      builder: (context, state) => EditProfilePage(),
    ),
    // Used
    GoRoute(
      path: '/signUp',
      name: '/signUp',
      builder: (context, state) => SignUp(),
    ),
    // Used
    GoRoute(
      path: '/onboarding_first',
      name: '/onboarding_first',
      builder: (context, state) => const GetInspiredPage(),
    ),
  ],
);
