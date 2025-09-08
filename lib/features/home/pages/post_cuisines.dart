import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../managers/post_cuisines_vm.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CuisineVM(),
      child: Consumer<CuisineVM>(
        builder: (context, vm, _) {
          return Scaffold(
            extendBody: true,
            backgroundColor: const Color(0xFF1B0C0C), // dark background
            appBar: AppBar(
              backgroundColor: const Color(0xFF1B0C0C),
              elevation: 0,
              title: const Text(
                "Create Recipe",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              actions: [
                TextButton(
                  onPressed: () {}, // publish logic
                  child: const Text("Publish",
                      style: TextStyle(color: Colors.pinkAccent)),
                ),
                TextButton(
                  onPressed: () {}, // draft logic
                  child: const Text("Draft",
                      style: TextStyle(color: Colors.pinkAccent)),
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Video Upload Placeholder
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.pink[200],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(
                      child: Icon(Icons.play_circle_fill,
                          size: 64, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Title
                  TextField(
                    controller: vm.titleController,
                    decoration: _inputDecoration("Recipe Title"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),

                  // Description
                  TextField(
                    controller: vm.descriptionController,
                    decoration: _inputDecoration("Recipe Description"),
                    maxLines: 2,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 12),

                  // Time Recipe
                  TextField(
                    controller: vm.timeController,
                    decoration: _inputDecoration("Time: 30 min"),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),

                  // Ingredients
                  const Text("Ingredients",
                      style: TextStyle(color: Colors.pinkAccent)),
                  const SizedBox(height: 8),
                  const SizedBox(height: 20),
                  // Instructions
                  const Text("Instructions",
                      style: TextStyle(color: Colors.pinkAccent)),
                  const SizedBox(height: 8),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(bottom: 40.h, left: 40.w, right: 40.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent, // start fully transparent
                    Colors.black.withOpacity(0.4), // fade to darker
                  ],
                ),
                borderRadius: BorderRadius.circular(30.r),
              ),
              child: Container(
                width: 280.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFD5D69), // pink background
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/home.svg')),
                    IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/community.svg')),
                    IconButton(onPressed: (){}, icon: SvgPicture.asset('assets/icons/categories.svg')),
                    IconButton(onPressed: (){
                      context.go('/settings');
                    }, icon: SvgPicture.asset('assets/icons/profile.svg')),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF2A1C1C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
