import 'package:get/get.dart';

class DynamicAppSize {
  static double getScaledSize(
    double size,
  ) {
    double baseWidth = 390;
    double fem = Get.width / baseWidth;
    double ffem = fem * 0.97;
    return fem * size;
  }
}
