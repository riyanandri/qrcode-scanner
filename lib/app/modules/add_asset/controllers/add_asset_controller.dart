import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddAssetController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> addAsset(Map<String, dynamic> data) async {
    try {
      var hasil = await firestore.collection("assets").add(data);
      await firestore.collection("assets").doc(hasil.id).update({
        "assetId": hasil.id,
      });

      return {
        "error": false,
        "message": "Berhasil menambahkan data asset.",
      };
    } catch (e) {
      // print(e);
      // error general
      return {
        "error": true,
        "message": "Gagal menambahkan data asset.",
      };
    }
  }
}
