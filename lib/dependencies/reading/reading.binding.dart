import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/reading/reading.controller.dart';
import 'package:meter_reader_mobile/services/storage.service.dart';

class ReadingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<StorageService>(StorageService(), permanent: true);
    Get.put<ReadingController>(ReadingController(), permanent: true);
  }
}
