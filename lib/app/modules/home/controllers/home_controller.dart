import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qrcode_scanner/app/data/models/asset_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<AssetModel> allAssets = List<AssetModel>.empty().obs;

  void downloadPdf() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("assets").get();

    allAssets([]);

    for (var element in getData.docs) {
      allAssets.add(AssetModel.fromJson(element.data()));
    }

    var data = await rootBundle.load("assets/fonts/open-sans.ttf");
    var myFont = pw.Font.ttf(data);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          List<pw.TableRow> allData = List.generate(
            allAssets.length,
            (index) {
              AssetModel asset = allAssets[index];
              return pw.TableRow(
                children: [
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text("${index + 1}",
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 10,
                        )),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(asset.code,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 10,
                        )),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(asset.name,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 10,
                        )),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(asset.type,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 10,
                        )),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.Text(asset.room,
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          font: myFont,
                          fontSize: 10,
                        )),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.all(20),
                    child: pw.BarcodeWidget(
                        color: PdfColor.fromHex("#000000"),
                        barcode: pw.Barcode.qrCode(),
                        data: asset.code,
                        height: 50,
                        width: 50),
                  ),
                ],
              );
            },
          );

          return [
            pw.Center(
              child: pw.Text("Katalog Aset",
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    font: myFont,
                    fontSize: 24,
                  )),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(
                color: PdfColor.fromHex("#000000"),
                width: 2,
              ),
              children: [
                pw.TableRow(
                  children: [
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("No",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("Kode Aset",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("Nama Aset",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("Tipe",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("Ruangan",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                    pw.Padding(
                      padding: const pw.EdgeInsets.all(20),
                      child: pw.Text("QR Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                            font: myFont,
                            fontSize: 10,
                          )),
                    ),
                  ],
                ),
                ...allData,
              ],
            ),
          ];
        },
      ),
    );

    Uint8List bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File("${dir.path}/data-aset.pdf");

    await file.writeAsBytes(bytes);

    await OpenFile.open(file.path);
  }

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
