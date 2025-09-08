import 'package:flutter/material.dart';
import 'package:flutter_exam/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class InterativeProfilePage extends StatefulWidget {
  const InterativeProfilePage({super.key});

  @override
  State<InterativeProfilePage> createState() => _InterativeProfilePageState();
}

class _InterativeProfilePageState extends State<InterativeProfilePage> {
  final List<String> titles = ['Novice', 'Intermediate', 'Advanced', 'Expert'];
  final List<String> subtitles = [
    'You’re just getting started in the kitchen and learning basic recipes.',
    'You can follow most recipes and understand some cooking techniques.',
    'You’re confident in the kitchen and enjoy experimenting with complex dishes.',
    'You could cook with your eyes closed. You’re a culinary master!',
  ];
  int activeIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset('assets/icons/back-arrow.svg'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(12),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            height: 8,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: 0.25, // progress (1/4 step for this page)
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.pinkIconBack,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
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
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  final isActive = activeIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isActive
                              ? AppColors.pinkIconBack
                              : Colors.white24,
                          width: 1.5,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          titles[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: isActive
                                ? AppColors.pinkIconBack
                                : Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          subtitles[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: isActive
                                ? AppColors.pinkIconBack
                                : Colors.white70,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: GestureDetector(
          onTap: activeIndex != -1 ? () => context.go('/preference_page') : null,
          child: Container(
            margin: const EdgeInsets.only(bottom: 24, left: 70, right: 70),
            padding: const EdgeInsets.symmetric(horizontal: 56, vertical: 14),
            decoration: BoxDecoration(
              color: activeIndex != -1
                  ? AppColors.pinkIconBack
                  : Colors.white24,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
