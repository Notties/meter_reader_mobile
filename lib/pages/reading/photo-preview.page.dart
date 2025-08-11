import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhotoPreviewPage extends StatelessWidget {
  const PhotoPreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>?;
    final path = args?['path'] as String?;
    return Scaffold(
      appBar: AppBar(title: const Text('ดูรูป')),
      body: Center(
        child: (path != null && File(path).existsSync())
            ? Image.file(File(path))
            : const Text('ไม่พบรูป'),
      ),
    );
  }
}
