import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/reading/reading.controller.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut(() => ReadingController());
  }
}
