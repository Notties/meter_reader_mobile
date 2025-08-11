import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/reading/reading.controller.dart';

class ReadingFormPage extends StatelessWidget {
  const ReadingFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ReadingController>();

    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกค่าน้ำ')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: c.formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: c.meterIdCtrl,
                decoration: const InputDecoration(labelText: 'หมายเลขมิเตอร์'),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'กรอกหมายเลขมิเตอร์'
                    : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: c.valueCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'ค่าน้ำ (หน่วย)'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'กรอกค่าน้ำ' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: c.noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'หมายเหตุ (ถ้ามี)',
                ),
              ),
              const SizedBox(height: 16),
              Obx(() {
                final p = c.photoPath.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'รูปถ่ายมิเตอร์',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    if (p != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          File(p),
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Container(
                        height: 160,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: const Text('ยังไม่มีรูป'),
                      ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: c.pickCamera,
                          icon: const Icon(Icons.camera_alt),
                          label: const Text('ถ่ายรูป'),
                        ),
                        const SizedBox(width: 12),
                        if (p != null)
                          TextButton.icon(
                            onPressed: () => c.photoPath.value = null,
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('ลบรูป'),
                          ),
                      ],
                    ),
                  ],
                );
              }),
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: c.saveForm,
                icon: const Icon(Icons.save),
                label: const Text('บันทึก'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
