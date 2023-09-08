import 'package:get/get.dart';

import '../modules/add_asset/bindings/add_asset_binding.dart';
import '../modules/add_asset/views/add_asset_view.dart';
import '../modules/assets/bindings/assets_binding.dart';
import '../modules/assets/views/assets_view.dart';
import '../modules/detail_asset/bindings/detail_asset_binding.dart';
import '../modules/detail_asset/views/detail_asset_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.addAsset,
      page: () => AddAssetView(),
      binding: AddAssetBinding(),
    ),
    GetPage(
      name: _Paths.assets,
      page: () => const AssetsView(),
      binding: AssetsBinding(),
    ),
    GetPage(
      name: _Paths.detailAsset,
      page: () => DetailAssetView(),
      binding: DetailAssetBinding(),
    ),
  ];
}
