import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../colors.dart';
import '../managers/onboarding_improve_view_model.dart';

class OnBoardingImprove extends StatefulWidget {
  const OnBoardingImprove({super.key});

  @override
  State<OnBoardingImprove> createState() => _OnBoardingImproveState();
}

class _OnBoardingImproveState extends State<OnBoardingImprove> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnBoardingImproveViewModel(),
      builder: (context, child) {
        return Consumer<OnBoardingImproveViewModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (vm.error != null) {
              return Scaffold(
                body: Center(child: Text('Error: ${vm.error}')),
              );
            }

            if (vm.onboarding.isEmpty || vm.onboarding.length < 2) {
              return const Scaffold(
                body: Center(child: Text('No data')),
              );
            }

            final data = vm.onboarding[1]; // Second item (order 2)

            return Scaffold(
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      data.image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Center(child: Text('Image failed to load')),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.backgroundColor.withOpacity(0.7),
                            AppColors.backgroundColor.withOpacity(0.3),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            'Get An Increase Your Skills',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Learn essential cooking techniques at your own pace.',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                context.goNamed('/onboardinglastPage');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.pinkIcon,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}