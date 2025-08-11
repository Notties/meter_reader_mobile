import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meter_reader_mobile/app/core/routes/routes.path.dart';
import 'package:meter_reader_mobile/models/reading/reading.model.dart';
import 'package:meter_reader_mobile/services/storage.service.dart';
import 'package:permission_handler/permission_handler.dart';

class ReadingController extends GetxController {
  final storage = Get.find<StorageService>();

  final items = <Reading>[].obs;
  final meterIdCtrl = TextEditingController();
  final valueCtrl = TextEditingController();
  final noteCtrl = TextEditingController();
  final photoPath = RxnString();
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    items.assignAll(await storage.loadAll());
  }

  Future<void> pickCamera() async {
    final status = await Permission.camera.request();
    if (!status.isGranted) {
      Get.snackbar('Camera', 'ต้องอนุญาตสิทธิ์กล้องก่อนใช้งาน');
      return;
    }
    final x = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
      maxWidth: 1600,
    );
    if (x != null) photoPath.value = x.path;
  }

  Future<void> saveForm() async {
    if (!formKey.currentState!.validate()) return;

    final id = DateTime.now().microsecondsSinceEpoch.toString();
    String? savedPhoto;
    if (photoPath.value != null) {
      savedPhoto = await storage.saveImage(
        File(photoPath.value!),
        meterIdCtrl.text.trim(),
        id,
      );
    }

    final reading = Reading(
      id: id,
      meterId: meterIdCtrl.text.trim(),
      value: valueCtrl.text.trim(),
      note: noteCtrl.text.trim().isEmpty ? null : noteCtrl.text.trim(),
      photoPath: savedPhoto,
      createdAt: DateTime.now(),
    );

    items.insert(0, reading);
    await storage.saveAll(items.toList());

    meterIdCtrl.clear();
    valueCtrl.clear();
    noteCtrl.clear();
    photoPath.value = null;

    Get.until((route) => Get.currentRoute == RoutesPath.readingList);
    Get.snackbar('บันทึกสำเร็จ', 'บันทึกการอ่านแล้ว');
  }

  void openPhoto(String path) {
    Get.toNamed(RoutesPath.photoPreview, arguments: {'path': path});
  }
}
