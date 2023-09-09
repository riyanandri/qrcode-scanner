import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:qrcode_scanner/app/data/models/asset_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<AssetModel> allAssets = List<AssetModel>.empty().obs;

  Future getAssetById(String codeAset) async {
    try {
      var hasil = await firestore
          .collection("assets")
          .where("code", isEqualTo: codeAset)
          .get();
      if (hasil.docs.isEmpty) {
        return {
          "error": true,
          "message": "Tidak ada aset dengan kode ini.",
        };
      }
      Map<String, dynamic> data = hasil.docs.first.data();
      return {
        "error": false,
        "message": "Berhasil mendapatkan detail aset dari kode ini.",
        "data": AssetModel.fromJson(data),
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Terjadi kesalahan saat mengambil detail aset.",
      };
    }
  }
}
