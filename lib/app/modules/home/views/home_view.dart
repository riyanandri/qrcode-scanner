import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qrcode_scanner/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
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
              title = "Tambah Asset";
              icon = Icons.post_add_rounded;
              onTap = () => Get.toNamed(Routes.addAsset);
              break;
            case 1:
              title = "Data Asset";
              icon = Icons.list_alt_outlined;
              onTap = () => Get.toNamed(Routes.assets);
              break;
            case 2:
              title = "QR Code";
              icon = Icons.qr_code;
              onTap = () {
                print("Open Camera");
              };
              break;
            case 3:
              title = "Scan QR";
              icon = Icons.document_scanner_outlined;
              onTap = () {
                print("Export Excel");
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
