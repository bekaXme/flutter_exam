import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_exam/colors.dart';
import 'package:provider/provider.dart';
import '../../../../data/models/home/cooking_level_model.dart';

class CookingLevel extends StatelessWidget {
  const CookingLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CookingLevelModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          leading: IconButton(
            onPressed: () {
              context.goNamed('/definition');
            },
            icon: Icon(Icons.arrow_back, color: Colors.pink),
          ),
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 80),
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
        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Select your cuisines preferences',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Please select your cuisines preferences for better recommendations or you can skip it.',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Consumer<CookingLevelModel>(
                builder: (context, vm, child) => GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,

                  ),
                  itemCount: vm.cuisines.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          vm.cuisines[index]['image'],
                          width: 98,
                          height: 98,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        vm.cuisines[index]['title'],
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 46),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFFC6C9),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        context.goNamed('/logIn');
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: Color(0xFFEC888D)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFFFD5D69),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                        context.goNamed('/allergy');
                      },
                      child: const Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
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
