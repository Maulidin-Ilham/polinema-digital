import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final response = await http.get(Uri.parse(uri));

    try {
      var data = json.decode(response.body);
      // Lakukan sesuatu dengan data JSON
      final sebaranGender = {
        "persentageFemale": data['female_precentage'],
        "persentageMale": data['male_precentage'],
      };

      return sebaranGender;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
    }
  }

  static Future getAllResponden(String? nation) async {
    Dio dio = Dio();
    String? url = dotenv.env['BASE_URL'];

    // final data = response.data['data'].toString();
    // print(responseData);

    try {
      var response = await dio.get('$url/api/responden/nationality/$nation');
      final data = response.data;

      final count = data['count'];

      final genreList = List<String>.from(data['genreList']);
      final genreCount = Map<String, int>.from(data['genreCount']);


      // for (var responden in dataList){

      // }
      // Lakukan sesuatu dengan data JSON
      // final genreList = data['genreList'];
      // final genreCount = data['genreCount'];

      final resultMap = {
        "nation": nation,
        "genreList": genreList,
        "genreCount": genreCount,
      };
      print(resultMap);
      // print("WOIWOIWOI");

      // // print(filterNation);

      return resultMap;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
      return null;
    }
  }
}
