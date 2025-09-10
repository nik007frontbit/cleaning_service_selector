import 'package:cleaning_service_selector/view/splash/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'config/app_colors.dart';
import 'widget/controllerinitialize.dart';

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeController();
  ///Portrait orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cleaning Service Selector',
      scaffoldMessengerKey: rootScaffoldMessengerKey,
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldColor,
        drawerTheme: DrawerThemeData(backgroundColor: AppColors.whiteColor),
        appBarTheme: AppBarTheme(backgroundColor: AppColors.primary, foregroundColor: AppColors.whiteColor),
        tabBarTheme: TabBarThemeData(
          labelColor: AppColors.whiteColor,
          unselectedLabelColor: AppColors.whiteColor,
          indicatorColor: AppColors.whiteColor,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
        ),
        // DatePicker theme
        datePickerTheme: DatePickerThemeData(
          backgroundColor: Colors.white,
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: AppColors.whiteColor,
          dayForegroundColor: WidgetStatePropertyAll(AppColors.textColor),
          todayForegroundColor: WidgetStatePropertyAll(AppColors.secondary),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),

        // TimePicker theme
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          hourMinuteTextColor: AppColors.primary,
          dayPeriodTextColor: AppColors.primary,
          dialBackgroundColor: AppColors.primary.withValues(alpha: 0.1),
          dialHandColor: AppColors.primary,
          entryModeIconColor: AppColors.primary,
        ),

        switchTheme: SwitchThemeData(
          trackColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.secondary; // Active track color
            }
            return AppColors.greyColor; // Inactive track color
          }),
          thumbColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.whiteColor; // Active thumb
            }
            return Colors.white70; // Inactive thumb
          }),
        ),
        fontFamily: "Roboto",
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
