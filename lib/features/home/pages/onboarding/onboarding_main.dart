import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/onboarding/onboarding_model.dart';

class GetInspiredPage extends StatelessWidget {
  const GetInspiredPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnBoardingMainModel()..fetchOnBoardingItems(), // load data
      builder: (context, child) {
        return Consumer<OnBoardingMainModel>(
          builder: (context, vm, child) {
            if (vm.isLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (vm.error != null) {
              return Scaffold(
                body: Center(child: Text(vm.error!)),
              );
            }
            final data = vm.onboarding[0];
            return Scaffold(
              body: Stack(
                children: [
                  // Background image from API
                  Positioned.fill(
                    child: Image.network(
                      data.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Dark overlay
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  // Content
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            data.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            data.subtitle,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: null, // disabled
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink[200],
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
