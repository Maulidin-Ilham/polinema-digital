import 'package:dio/dio.dart';
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

  factory Responden.fromJson(Map<String, dynamic> json) {
    return Responden(
      id: json['id'],
      age: json['age'],
      year: json['year'],
      gpa: json['gpa'].toDouble(),
      gender: json['gender'],
      genre: json['genre'],
      nationality: json['nationality'],
      reports: json['reports'],
    );
  }

  static Future getAllResponden(String? nation) async {
    String? url = dotenv.env['BASE_URL'];
    Dio dio = Dio();

    try {
      if (nation == null || nation.isEmpty) {
        String uri = "$url/api/responden";

        var response = await dio.get(uri);
        final data = response.data;

        final genreList = data['genreList'];
        final genreCount = data['genreCount'];
        final allRespondens = data['data'];

        final allData = {
          "genreList": genreList,
          "genreCount": genreCount,
          "allRespondens": allRespondens
        };

        return allData;
      } else {
        String uri = "$url/api/responden/nationality/$nation";

        var response = await dio.get(uri);
        final data = response.data;

        final genreList = data['genreList'];
        final genreCount = data['genreCount'];
        final allRespondens = data['data'];

        final allData = {
          "nation": nation,
          "genreList": genreList,
          "genreCount": genreCount,
          "allRespondens": allRespondens
        };

        return allData;
      }
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
    }
  }

  static Future<List<dynamic>> getDetailData(String? nation, String genre) async {
    String? url = dotenv.env['BASE_URL'];
    Dio dio = Dio();
    print("$nation dengan genre $genre");

    try {
      if (nation == null || nation.isEmpty) {
        String uri = "$url/api/responden/nationality/$nation/$genre";

        var response = await dio.get(uri);
        final data = response.data['data'];
        print("INI ADDALAH DAYA $data");

        // final genreList = data['genreList'];
        // final genreCount = data['genreCount'];
        // final allRespondens = data['data'];

        // final allData = {
        //   "genreList": genreList,
        //   "genreCount": genreCount,
        //   "allRespondens": allRespondens
        // };

        // print(allData);

        // return allData;
      } else {
        String uri = "$url/api/responden/genre/$genre";

        var response = await dio.get(uri);
        final data = response.data['data'];

        return data;

        // final genreList = data['genreList'];
        // final genreCount = data['genreCount'];
        // final allRespondens = data['data'];

        // final allData = {
        //   "nation": nation,
        //   "genreList": genreList,
        //   "genreCount": genreCount,
        //   "allRespondens": allRespondens
        // };

        // print(allData);

        // return allData;
      }
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
    }
    return [];
  }

  static Future getDataStatistic() async {
    final dio = Dio();
    String? url = dotenv.env['BASE_URL'];

    try {
      String uri = "$url/api/data-survey";
      var response = await dio.get(uri);

      final data = response.data;

      final persenMale = data['male_precentage'];
      final persenFemale = data['female_precentage'];
      final totalResponden = data['reponden_all'];

      String umurStr = data['average_age'].toString();
      double umurDouble = double.parse(umurStr);
      int umur = umurDouble.toInt();

      String gpaStr = response.data['average_gpa'].toString();
      double gpa = double.parse(gpaStr);

      final dataStatistic = {
        "totalResponden": totalResponden,
        "rerataUmur": umur,
        "rerataGpa": gpa,
        "persentageFemale": persenFemale,
        "persentageMale": persenMale,
      };

      return dataStatistic;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: ${e.toString()}');
    }
  }
}
