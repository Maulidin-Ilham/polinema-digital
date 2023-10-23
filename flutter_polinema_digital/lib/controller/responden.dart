import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_polinema_digital/view/home.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Responden {
  int id;
  int age;
  double gpa;
  int year;
  String gender;
  String nationality;
  String genre;
  String reports;

  Responden(
      {required this.id,
      required this.age,
      required this.year,
      required this.gpa,
      required this.gender,
      required this.genre,
      required this.nationality,
      required this.reports});

  static Future getSebaranGender() async {
    String? url = dotenv.env['BASE_URL'];

    String uri = "$url/api/responden";
    final dio = Dio();

// customization
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    );

    try {
      //  final response = await http.get(Uri.parse(uri));
      final response = await dio.get(uri);

      print(response.data);

      // var data = json.decode(response.body);
      // Lakukan sesuatu dengan data JSON

      final sebaranGender = {
        "persentageFemale": 0,
        "persentageMale": 0,
      };

      return sebaranGender;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: ${e.toString()}');
    }
  }

  static Future getAllResponden(String? nation) async {
    String? url = dotenv.env['BASE_URL'];

    String uri = "$url/api/responden/nationality/$nation";
    final response = await http.get(Uri.parse(uri));
    print(response.body);

    try {
      var data = json.decode(response.body);

      // Lakukan sesuatu dengan data JSON
      final sebaranGender = {
        "nation": nation,
        "genreList": data['genreList'],
        "genreCount": data['genreCount'],
      };
      print(sebaranGender);

      return sebaranGender;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
    }

    // Dio dio = Dio();
    // String? url = dotenv.env['BASE_URL'];

    // // final data = response.data['data'].toString();
    // // print(responseData);

    // try {
    //   var response = await dio.get('$url/api/responden/nationality/$nation');
    //   final data = response.data;
    //   print(data);

    //   final count = data['count'];

    //   final genreList = List<String>.from(data['genreList']);
    //   print("genreList => $genreList");
    //   final genreCount = List<Map<String, int>>.from(data['genreCount']);
    //   print("genreCount => $genreCount");

    //   // for (var responden in dataList){

    //   // }
    //   // Lakukan sesuatu dengan data JSON
    //   // final genreList = data['genreList'];
    //   // final genreCount = data['genreCount'];

    // final resultMap = {
    //   "nation": nation,
    //   "count": count,
    //   "genreList": genreList,
    //   "genreCount": genreCount,
    // };
    // print(resultMap);
    // print("WOIWOIWOI");

    // // print(filterNation);
  }
}
