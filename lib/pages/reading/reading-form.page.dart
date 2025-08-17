import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/controller/reading/reading.controller.dart';

class ReadingFormPage extends StatelessWidget {
  const ReadingFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<ReadingController>();

    final inputTheme = Theme.of(context).inputDecorationTheme.copyWith(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('บันทึกค่าน้ำ')),
      body: SafeArea(
        child: Form(
          key: c.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Theme(
                    data: Theme.of(
                      context,
                    ).copyWith(inputDecorationTheme: inputTheme),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'รายละเอียดมิเตอร์',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: c.meterIdCtrl,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            labelText: 'หมายเลขมิเตอร์',
                            prefixIcon: Icon(
                              Icons.confirmation_number_outlined,
                            ),
                            hintText: 'เช่น 001234',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'กรอกหมายเลขมิเตอร์'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: c.valueCtrl,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: const InputDecoration(
                            labelText: 'ค่าน้ำ (หน่วย)',
                            prefixIcon: Icon(Icons.water_drop_outlined),
                            hintText: 'เช่น 125',
                          ),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'กรอกค่าน้ำ'
                              : null,
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: c.noteCtrl,
                          minLines: 2,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: 'หมายเหตุ (ถ้ามี)',
                            prefixIcon: Icon(Icons.sticky_note_2_outlined),
                            hintText:
                                'รายละเอียดเพิ่มเติม เช่น ตำแหน่งมิเตอร์ / ปัญหา',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Obx(() {
                final p = c.photoPath.value;

                return Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'รูปถ่ายมิเตอร์',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 12),

                        GestureDetector(
                          onTap: c.pickCamera,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              height: 220,
                              color: Colors.black12,
                              child: p != null && File(p).existsSync()
                                  ? Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        Image.file(File(p), fit: BoxFit.cover),
                                        Positioned(
                                          top: 8,
                                          right: 8,
                                          child: Row(
                                            children: [
                                              Material(
                                                color: Colors.black54,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: IconButton(
                                                  tooltip: 'ถ่ายใหม่',
                                                  icon: const Icon(
                                                    Icons.camera_alt,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: c.pickCamera,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Material(
                                                color: Colors.black54,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: IconButton(
                                                  tooltip: 'ลบรูป',
                                                  icon: const Icon(
                                                    Icons.delete_outline,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () =>
                                                      c.photoPath.value = null,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          Icon(Icons.photo_outlined, size: 48),
                                          SizedBox(height: 8),
                                          Text('แตะเพื่อถ่ายรูปมิเตอร์'),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

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
                    ),
                  ),
                );
              }),

              const SizedBox(height: 80), // กันพื้นที่ปุ่มล่าง
            ],
          ),
        ),
      ),

      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: FilledButton.icon(
          onPressed: c.saveForm,
          icon: const Icon(Icons.save),
          label: const Text('บันทึก'),
          style: FilledButton.styleFrom(
            minimumSize: const Size.fromHeight(52),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
