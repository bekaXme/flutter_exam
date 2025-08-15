import 'package:flutter/material.dart';
import 'package:flutter_exam/core/services/client.dart';
import 'package:flutter_exam/data/repositories/auth_repository.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/routing/routers.dart' as AppRouter;
import 'features/home/managers/view_model.dart';
import 'features/home/pages/home_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (_) => ApiClient()),
        Provider(create: (context) => AuthenticationRepository(client: context.read())),
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
      ],
      child: MainAccountPage(),
    ),
  );
}


class MainAccountPage extends StatelessWidget {
  const MainAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
      )
    );
  }
}
