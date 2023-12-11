import 'package:dio/dio.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/dataBar.dart';

class Akademik {
  static Future getDataAkademik() async {
    final dio = Dio();
    String? url = dotenv.env['BASE_URL'];

    try {
      String uri = "$url/api/studentDashboard";
      var response = await dio.get(uri);

      final data = response.data;

      final allStudent = data['allStudent'];
      final studentLulus = data['studentLulus'];
      final studentTidakLulus = data['studentTidakLulus'];
      final ipk2018 = data['ipk2018'];
      final ipk2019 = data['ipk2019'];
      final ipk2020 = data['ipk2020'];
      final ipk2021 = data['ipk2021'];

      List<Data> barData = [
        Data(id: 0, name: "ipk2018", y: ipk2018),
        Data(id: 1, name: "ipk2019", y: ipk2019),
        Data(id: 2, name: "ipk2020", y: ipk2020),
        Data(id: 3, name: "ipk2021", y: ipk2021),
      ];

      final dataAkademik = {
        "allStudent": allStudent,
        "studentLulus": studentLulus,
        "studentTidakLulus": studentTidakLulus,
        "barData": barData,
      };


      return dataAkademik;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: ${e.toString()}');
    }
  }

  static Future<List<BarChartGroupData>> getIPKBar() async {
    final dio = Dio();
    String? url = dotenv.env['BASE_URL'];

    try {
      String uri = "$url/api/studentDashboard";
      var response = await dio.get(uri);

      final data = response.data;

      final ipk2018 = data['ipk2018'];
      final ipk2019 = data['ipk2019'];
      final ipk2020 = data['ipk2020'];
      final ipk2021 = data['ipk2021'];

      List<BarChartGroupData> barData = [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(toY: ipk2018, width: 10)
          ]
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(toY: ipk2019, width: 10),
          ]
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(toY: ipk2020, width: 10),
          ]
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(toY: ipk2021, width: 10),
          ]
        ),
        
      ];


      return barData;
    } catch (e) {
      print('Kesalahan saat mengurai JSON: ${e.toString()}');
      return [];
    }
  }
}
