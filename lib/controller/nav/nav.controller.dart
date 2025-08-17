import 'package:get/get.dart';

class NavController extends GetxController {
  final current = 0.obs;

  void to(int i) => current.value = i;

  bool isFirstTab() => current.value == 0;
}
