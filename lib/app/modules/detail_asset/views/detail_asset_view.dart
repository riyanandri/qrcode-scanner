import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_asset_controller.dart';

class DetailAssetView extends GetView<DetailAssetController> {
  const DetailAssetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailAssetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'DetailAssetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
