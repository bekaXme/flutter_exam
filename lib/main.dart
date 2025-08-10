import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/feature/pages/home_page.dart';

void main() {
  runApp(MainAccountPage());
}

class MainAccountPage extends StatelessWidget {
  const MainAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
