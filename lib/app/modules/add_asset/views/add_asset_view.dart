import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_asset_controller.dart';

class AddAssetView extends GetView<AddAssetController> {
  const AddAssetView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddAssetView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddAssetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
