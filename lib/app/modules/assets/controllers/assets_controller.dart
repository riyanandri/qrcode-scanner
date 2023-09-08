import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AssetsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAssets() async* {
    yield* firestore.collection("assets").snapshots();
  }
}
