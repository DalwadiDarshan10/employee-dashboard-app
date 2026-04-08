import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'routes/app_routes.dart';
import 'routes/name_routes.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            fontFamily: 'PlusJakartaSans',
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.background,
          ),
          initialRoute: NameRoutes.splash,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
