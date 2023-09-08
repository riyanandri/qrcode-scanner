import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailAssetController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> editAsset(Map<String, dynamic> data) async {
    try {
      await firestore.collection("assets").doc(data["id"]).update({
        "name": data["name"],
        "year": data["year"],
        "type": data["type"],
        "reg": data["reg"],
        "room": data["room"],
        "brand": data["brand"],
        "cond": data["cond"],
      });

      return {
        "error": false,
        "message": "Berhasil update data asset.",
      };
    } catch (e) {
      // print(e);
      // error general
      return {
        "error": true,
        "message": "Gagal update data asset.",
      };
    }
  }

  Future<Map<String, dynamic>> deleteAsset(String id) async {
    try {
      await firestore.collection("assets").doc(id).delete();

      return {
        "error": false,
        "message": "Berhasil menghapus data asset.",
      };
    } catch (e) {
      // print(e);
      // error general
      return {
        "error": true,
        "message": "Gagal menghapus data asset.",
      };
    }
  }
}
