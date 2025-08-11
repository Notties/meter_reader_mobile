import 'package:get/get.dart';
import 'package:meter_reader_mobile/app/core/routes/routes.path.dart';
import 'package:meter_reader_mobile/dependencies/reading/reading.binding.dart';
import 'package:meter_reader_mobile/pages/reading/photo-preview.page.dart';
import 'package:meter_reader_mobile/pages/reading/reading-form.page.dart';
import 'package:meter_reader_mobile/pages/reading/reading-list.page.dart';

class RoutePages {
  RoutePages._();

  static final pages = [
    GetPage(
      name: RoutesPath.readingList,
      page: () => const ReadingListPage(),
      binding: ReadingBinding(),
    ),
    GetPage(name: RoutesPath.readingForm, page: () => const ReadingFormPage()),
    GetPage(
      name: RoutesPath.photoPreview,
      page: () => const PhotoPreviewPage(),
    ),
  ];
}
