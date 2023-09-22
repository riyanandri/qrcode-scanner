import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:qrcode_scanner/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Aset DP4KB'),
        centerTitle: true,
      ),
      body: GridView.builder(
        itemCount: 4,
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          late String title;
          late IconData icon;
          late VoidCallback onTap;

          switch (index) {
            case 0:
              title = "Tambah Aset";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.addAsset);
              break;
            case 1:
              title = "Data Aset";
              icon = Icons.list_alt_outlined;
              onTap = () => Get.toNamed(Routes.assets);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
              onTap = () async {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                  "#000000",
                  "Batal",
                  true,
                  ScanMode.QR,
                );
                Map<String, dynamic> hasil =
                    await controller.getAssetById(barcode);
                if (hasil["error"] == false) {
                  Get.toNamed(Routes.detailAsset, arguments: hasil["data"]);
                } else {
                  Get.snackbar("Error", hasil["message"],
                      duration: const Duration(seconds: 2));
                }
                // Get.snackbar("Barcode", barcode);
              };
              break;
            case 3:
              title = "Katalog";
              icon = Icons.document_scanner_outlined;
              onTap = () {
                controller.downloadPdf();
                // showModalBottomSheet(
                //     context: context,
                //     builder: (context) {
                //       return Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           ListTile(
                //             leading: const Icon(Icons.photo),
                //             title: const Text('Download PDF'),
                //             onTap: () {
                //               controller.downloadPdf();
                //             },
                //           ),
                //           ListTile(
                //             leading: const Icon(Icons.music_note),
                //             title: const Text('Download CSV'),
                //             onTap: () {
                //               Navigator.pop(context);
                //             },
                //           ),
                //         ],
                //       );
                //     });
              };
              break;
          }

          return Material(
            color: Colors.grey.shade300,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(9),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        icon,
                        size: 50,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(title),
                  ]),
            ),
          );
        },
      ),
    );
  }
}
