import 'package:dio/dio.dart';

String baseURL = "http://192.168.100.6:8000/";

Future getAllResponse() async {
  String url = baseURL + "api/responden";
  try {
    var response = await Dio().get(url);

    if (response.statusCode == 200) {
      return response.data;
    }

    return null;
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<int?> getTotalResponden() async {
  String url = baseURL + "api/data-survey";
  try {
    var response = await Dio().get(url);

    if (response.statusCode == 200) {
      print(response.data['reponden_all']);
      return 2;
    }
    return null;
  } catch (e) {}
  return null;
}
