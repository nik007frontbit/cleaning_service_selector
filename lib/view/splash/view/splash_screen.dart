import 'package:cleaning_service_selector/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service_selection/view/service_selection_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAll(() => const ServiceSelectionScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Icon(Icons.cleaning_services, size: 100, color: AppColors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Cleaning Service Selector',
              style: TextStyle(color: AppColors.textColor, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
