import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qrcode_scanner/app/data/models/asset_model.dart';

import '../controllers/detail_asset_controller.dart';

class DetailAssetView extends GetView<DetailAssetController> {
  DetailAssetView({Key? key}) : super(key: key);

  final AssetModel asset = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController yearC = TextEditingController();
  final TextEditingController typeC = TextEditingController();
  final TextEditingController regC = TextEditingController();
  final TextEditingController roomC = TextEditingController();
  final TextEditingController brandC = TextEditingController();
  final TextEditingController condC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    codeC.text = asset.code;
    nameC.text = asset.name;
    yearC.text = asset.year;
    typeC.text = asset.type;
    regC.text = asset.reg;
    roomC.text = asset.room;
    brandC.text = asset.brand;
    condC.text = asset.cond;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Aset'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: QrImageView(
                  data: asset.code,
                  size: 200.0,
                  version: QrVersions.auto,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                width: 200,
                child: Image.network(
                  asset.image,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
            readOnly: true,
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "Kode Aset",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: nameC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Nama Aset",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: yearC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Tahun",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: typeC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Jenis",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: regC,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "No Register",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: roomC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Ruangan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: brandC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Merek",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            autocorrect: false,
            controller: condC,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: "Kondisi",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(9),
              ),
            ),
          ),
          const SizedBox(height: 35),
          ElevatedButton(
            onPressed: () async {
              if (controller.isLoading.isFalse) {
                if (nameC.text.isNotEmpty &&
                    yearC.text.isNotEmpty &&
                    typeC.text.isNotEmpty &&
                    regC.text.isNotEmpty &&
                    roomC.text.isNotEmpty &&
                    brandC.text.isNotEmpty &&
                    condC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.editAsset({
                    "id": asset.assetId,
                    "name": nameC.text,
                    "year": yearC.text,
                    "type": typeC.text,
                    "reg": regC.text,
                    "room": roomC.text,
                    "brand": brandC.text,
                    "cond": condC.text,
                  });
                  controller.isLoading(false);

                  Get.snackbar(
                    hasil["error"] == true ? "Error" : "Berhasil",
                    hasil["message"],
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Get.snackbar("error", "Semua data wajib di isi!",
                      duration: const Duration(seconds: 2));
                }
              }
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              padding: const EdgeInsets.symmetric(vertical: 20),
            ),
            child: Obx(
              () =>
                  Text(controller.isLoading.isFalse ? "Update" : "Loading..."),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Hapus Aset",
                  middleText: "Apakah anda yakin ingin menghapus?",
                  actions: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      child: const Text("Batal"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        controller.isLoadingDelete(true);
                        Map<String, dynamic> hasil =
                            await controller.deleteAsset(asset.assetId);
                        controller.isLoadingDelete(false);
                        Get.back();
                        Get.back();
                        Get.snackbar(
                          hasil["error"] == true ? "Error" : "Berhasil",
                          hasil["message"],
                          duration: const Duration(seconds: 2),
                        );
                      },
                      child: Obx(
                        () => controller.isLoadingDelete.isFalse
                            ? const Text("Hapus")
                            : Container(
                                padding: const EdgeInsets.all(2),
                                height: 15,
                                width: 15,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
              child: Text(
                "Hapus",
                style: TextStyle(color: Colors.red.shade900),
              ))
        ],
      ),
    );
  }
}
