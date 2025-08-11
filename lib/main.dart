import 'package:flutter/material.dart';
import 'package:meter_reader_mobile/dependencies/dependency.dart';
import 'app.dart';

void main() {
  DependencyCreator.init();
  runApp(const MeterReaderApp());
}
