import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:meter_reader_mobile/models/reading/reading.model.dart';

class StorageService extends GetxService {
  Directory? _imagesDir;
  File? _dbFile;
  bool _ready = false;

  Future<StorageService> init() async {
    if (_ready) return this;
    final appDir = await getApplicationDocumentsDirectory();
    _imagesDir = Directory('${appDir.path}/readings')
      ..createSync(recursive: true);
    _dbFile = File('${appDir.path}/readings.json');
    if (!await _dbFile!.exists()) {
      await _dbFile!.writeAsString('[]');
    }
    _ready = true;
    return this;
  }

  Future<void> ensureReady() async {
    if (!_ready) {
      await init();
    }
  }

  Future<List<Reading>> loadAll() async {
    await ensureReady();
    final txt = await _dbFile!.readAsString();
    final list = (jsonDecode(txt) as List).cast<Map<String, dynamic>>();
    return list.map((e) => Reading.fromJson(e)).toList();
  }

  Future<void> saveAll(List<Reading> items) async {
    await ensureReady();
    await _dbFile!.writeAsString(
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<String> saveImage(File src, String meterId, String id) async {
    await ensureReady();
    final ts = DateTime.now().millisecondsSinceEpoch;
    final file = File('${_imagesDir!.path}/${ts}_${meterId}_$id.jpg');
    await file.writeAsBytes(await src.readAsBytes());
    return file.path;
  }
}
