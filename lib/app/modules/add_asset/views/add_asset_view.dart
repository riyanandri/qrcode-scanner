import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/add_asset_controller.dart';

class AddAssetView extends GetView<AddAssetController> {
  AddAssetView({Key? key}) : super(key: key);
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
    String imageUrl = "";
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Data Asset'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          IconButton(
            onPressed: () async {
              ImagePicker imagePicker = ImagePicker();
              XFile? file =
                  await imagePicker.pickImage(source: ImageSource.camera);

              if (file == null) return;

              String uniqueFileName =
                  DateTime.now().millisecondsSinceEpoch.toString();

              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');

              Reference referenceImageToUpload =
                  referenceDirImages.child(uniqueFileName);

              try {
                await referenceImageToUpload.putFile(File(file.path));
                imageUrl = await referenceImageToUpload.getDownloadURL();
              } catch (e) {}
            },
            icon: const Icon(Icons.camera_alt),
          ),
          TextField(
            autocorrect: false,
            controller: codeC,
            keyboardType: TextInputType.number,
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
                if (imageUrl.isEmpty) {
                  Get.snackbar("Error", "Anda belum upload foto.");
                }
                if (codeC.text.isNotEmpty &&
                    nameC.text.isNotEmpty &&
                    yearC.text.isNotEmpty &&
                    typeC.text.isNotEmpty &&
                    regC.text.isNotEmpty &&
                    roomC.text.isNotEmpty &&
                    brandC.text.isNotEmpty &&
                    condC.text.isNotEmpty) {
                  controller.isLoading(true);
                  Map<String, dynamic> hasil = await controller.addAsset({
                    "code": codeC.text,
                    "name": nameC.text,
                    "year": yearC.text,
                    "type": typeC.text,
                    "reg": regC.text,
                    "room": roomC.text,
                    "brand": brandC.text,
                    "cond": condC.text,
                    "image": imageUrl,
                  });
                  controller.isLoading(false);

                  Get.back();

                  Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                      hasil["message"]);
                } else {
                  Get.snackbar("Error", "Semua data harus diisi."
                      // backgroundColor: Colors.red,
                      // colorText: Colors.white,
                      // snackPosition: SnackPosition.BOTTOM,
                      );
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
              () => Text(
                  controller.isLoading.isFalse ? "Tambah Data" : "Loading..."),
            ),
          ),
        ],
      ),
    );
  }
}
