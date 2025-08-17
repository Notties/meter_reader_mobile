import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/models/reading/reading.model.dart';

class ReadingDetailPage extends StatelessWidget {
  const ReadingDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final reading = Get.arguments as Reading;
    final path = reading.photoPath;

    return Scaffold(
      appBar: AppBar(
        title: Text('มิเตอร์ ${reading.meterId}'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.close),
        label: const Text('ปิด'),
        onPressed: Get.back,
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 4 / 3,
            child: Container(
              color: Colors.black12,
              child: (path != null && File(path).existsSync())
                  ? InteractiveViewer(
                      child: Image.file(File(path), fit: BoxFit.cover),
                    )
                  : const Center(child: Text('ไม่มีรูปภาพ')),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.speed, size: 28),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'รายละเอียดมิเตอร์',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                          Chip(
                            label: Text(
                              _formatDate(reading.createdAt),
                              style: const TextStyle(fontSize: 12),
                            ),
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      const Divider(height: 24),

                      _InfoRow(
                        icon: Icons.confirmation_number_outlined,
                        label: 'Meter ID',
                        value: reading.meterId,
                      ),
                      _InfoRow(
                        icon: Icons.water_drop_outlined,
                        label: 'ค่าน้ำ',
                        value: reading.value,
                      ),
                      if ((reading.note ?? '').trim().isNotEmpty) ...[
                        _InfoRow(
                          icon: Icons.sticky_note_2_outlined,
                          label: 'บันทึก',
                          value: reading.note!,
                          multiline: true,
                        ),
                      ],
                      if ((reading.photoPath ?? '').isNotEmpty)
                        _InfoRow(
                          icon: Icons.photo_outlined,
                          label: 'ไฟล์รูป',
                          value: reading.photoPath!,
                          overflowFade: true,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------- Widgets & Helpers ----------
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool multiline;
  final bool overflowFade;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.multiline = false,
    this.overflowFade = false,
  });

  @override
  Widget build(BuildContext context) {
    final textStyleLabel = Theme.of(
      context,
    ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]);

    final textStyleValue = Theme.of(context).textTheme.bodyMedium;

    Widget valueWidget = Text(
      value,
      style: textStyleValue,
      maxLines: multiline ? null : 1,
      overflow: overflowFade
          ? TextOverflow.ellipsis
          : (multiline ? TextOverflow.visible : TextOverflow.clip),
      softWrap: multiline,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: multiline
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 22),
          const SizedBox(width: 12),
          SizedBox(width: 90, child: Text(label, style: textStyleLabel)),
          const SizedBox(width: 12),
          Expanded(child: valueWidget),
        ],
      ),
    );
  }
}

String _two(int n) => n.toString().padLeft(2, '0');
String _formatDate(DateTime dt) {
  return '${dt.year}-${_two(dt.month)}-${_two(dt.day)} ${_two(dt.hour)}:${_two(dt.minute)}';
}
