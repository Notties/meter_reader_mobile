import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/models/reading/reading.model.dart';
import 'package:path_provider/path_provider.dart';

class StorageService extends GetxService {
  late Directory _appDir;
  late Directory _imagesDir;
  late File _dbFile;

  Future<StorageService> init() async {
    _appDir = await getApplicationDocumentsDirectory();
    _imagesDir = Directory('${_appDir.path}/readings');
    if (!_imagesDir.existsSync()) _imagesDir.createSync(recursive: true);
    _dbFile = File('${_appDir.path}/readings.json');
    if (!_dbFile.existsSync()) {
      await _dbFile.writeAsString(jsonEncode([]));
    }
    return this;
  }

  Future<List<Reading>> loadAll() async {
    final txt = await _dbFile.readAsString();
    final list = (jsonDecode(txt) as List).cast<Map<String, dynamic>>();
    return list.map((e) => Reading.fromJson(e)).toList();
  }

  Future<void> saveAll(List<Reading> items) async {
    await _dbFile.writeAsString(
      jsonEncode(items.map((e) => e.toJson()).toList()),
    );
  }

  Future<String> saveImage(File src, String meterId, String id) async {
    final ts = DateTime.now().millisecondsSinceEpoch;
    final file = File('${_imagesDir.path}/${ts}_${meterId}_$id.jpg');
    await file.writeAsBytes(await src.readAsBytes());
    return file.path;
  }
}
