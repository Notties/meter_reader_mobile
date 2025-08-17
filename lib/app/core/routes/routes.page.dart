import 'package:get/get.dart';
import 'package:meter_reader_mobile/app/core/routes/routes.path.dart';
import 'package:meter_reader_mobile/dependencies/reading/reading.binding.dart';
import 'package:meter_reader_mobile/pages/reading/reading-detail.page.dart';
import 'package:meter_reader_mobile/pages/reading/reading-form.page.dart';
import 'package:meter_reader_mobile/pages/reading/reading-list.page.dart';
import 'package:meter_reader_mobile/pages/shell/home-shell.page.dart';
import 'package:meter_reader_mobile/pages/user/user.page.dart';

class RoutePages {
  RoutePages._();

  static final pages = [
    GetPage(
      name: RoutesPath.home,
      page: () => const HomeShellPage(),
      binding: ReadingBinding(),
    ),
    GetPage(
      name: RoutesPath.readingList,
      page: () => const ReadingListPage(),
      binding: ReadingBinding(),
    ),
    GetPage(name: RoutesPath.readingForm, page: () => const ReadingFormPage()),
    GetPage(
      name: RoutesPath.photoPreview,
      page: () => const ReadingDetailPage(),
    ),
    GetPage(name: RoutesPath.user, page: () => const UserPage()),
  ];
}
