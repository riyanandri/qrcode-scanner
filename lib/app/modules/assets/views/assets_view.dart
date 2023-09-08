import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/app/data/models/asset_model.dart';
import 'package:qrcode_scanner/app/routes/app_pages.dart';

import '../controllers/assets_controller.dart';

class AssetsView extends GetView<AssetsController> {
  const AssetsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Aset'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamAssets(),
          builder: (context, snapAssets) {
            if (snapAssets.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapAssets.data!.docs.isEmpty) {
              return const Center(
                child: Text("Data aset tidak ditemukan"),
              );
            }

            List<AssetModel> allAssets = [];

            for (var element in snapAssets.data!.docs) {
              allAssets.add(AssetModel.fromJson(element.data()));
            }
            return ListView.builder(
              itemCount: allAssets.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                AssetModel asset = allAssets[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(Routes.detailAsset, arguments: asset);
                    },
                    borderRadius: BorderRadius.circular(9),
                    child: Container(
                      height: 100,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(asset.code,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    )),
                                const SizedBox(height: 5),
                                Text(asset.name),
                                Text("${asset.brand} - ${asset.year}"),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: QrImageView(
                              data: asset.code,
                              size: 200.0,
                              version: QrVersions.auto,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
