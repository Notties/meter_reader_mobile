import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/reading/reading.controller.dart';

class ReadingListPage extends StatelessWidget {
  const ReadingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ReadingController>();
    return Scaffold(
      appBar: AppBar(title: const Text('รายการบันทึกค่าน้ำ')),
      body: Obx(() {
        if (c.items.isEmpty) {
          return const Center(
            child: Text('ยังไม่มีข้อมูล กด + เพื่อบันทึกใหม่'),
          );
        }
        return ListView.separated(
          itemCount: c.items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (_, i) {
            final r = c.items[i];
            return ListTile(
              leading: (r.photoPath != null && File(r.photoPath!).existsSync())
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.file(
                        File(r.photoPath!),
                        width: 56,
                        height: 56,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.photo_outlined),
              title: Text('มิเตอร์: ${r.meterId}   ค่าน้ำ: ${r.value}'),
              subtitle: Text('${r.createdAt}'),
              onTap: () {
                if (r.photoPath != null) c.openPhoto(r);
              },
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  Get.defaultDialog(
                    title: 'ยืนยันการลบ',
                    middleText: 'คุณต้องการลบข้อมูลนี้หรือไม่?',
                    textCancel: 'ยกเลิก',
                    textConfirm: 'ลบ',
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Get.back();
                      c.deleteReading(r.id);
                    },
                  );
                },
              ),
            );
          },
        );
      }),
    );
  }
}
