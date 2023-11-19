import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LaporanServices {
  static Future create_laporan(
      String nim,
      String name,
      String nohp,
      String jenis_laporan,
      String? other_jenis_laporan,
      String kronologi,
      File imageFile) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      // Pengguna telah terotentikasi, lakukan aksi yang diinginkan di sini
      String? url = dotenv.env['BASE_URL'];
      Dio dio = Dio();

      String filename = basename(imageFile.path);
      Reference storageRef = FirebaseStorage.instance.ref().child(filename);
      await storageRef.putFile(imageFile);

      String downloadURL = await storageRef.getDownloadURL();

      String jenis_laporan_fix =
          (jenis_laporan == "Other") ? other_jenis_laporan! : jenis_laporan;

      try {
        await dio.post(
            '$url/api/laporan?nim=2141762122&name=Halim Teguh&nohp=6281234345656&jenis_laporan=Pelecehan&kronologi=Pelecehan Seksual&buktiPath=foto-bukti',
            queryParameters: {
              'nim': nim,
              'name': name,
              'nohp': nohp,
              'jenis_laporan': jenis_laporan_fix,
              'kronologi': kronologi,
              'buktiPath': downloadURL
            });
      } catch (e) {
        print('Error uploading data to API: $e');
      }
    } else {
      // Pengguna belum terotentikasi, minta mereka untuk melakukan otentikasi
      print("Harus Login");
    }
  }
}
