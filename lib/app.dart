import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meter_reader_mobile/app/core/routes/routes.page.dart';
import 'package:meter_reader_mobile/app/core/routes/routes.path.dart';

class MeterReaderApp extends StatelessWidget {
  const MeterReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meter Reader',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      getPages: RoutePages.pages,
      initialRoute: RoutesPath.home,
    );
  }
}
