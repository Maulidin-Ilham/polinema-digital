import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_polinema_digital/controller/getData.dart';
import 'package:flutter_polinema_digital/models/preview.dart';
import 'package:google_fonts/google_fonts.dart';

String? url = dotenv.env['BASE_URL'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //Get Data Responden

    if (imageUrl == null) {
      imageUrl =
          'https://images.unsplash.com/photo-1640951613773-54706e06851d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1160&q=80';
    }

    if (name == null) {
      name = email;
    }

    String role = '';
    if (email!.contains("polinema")) {
      role = "Student of Polinema";
    } else {
      role = "PolinemaDigital users";
    }

    final List<String> items = ["Indonesia", "Soudan", "France"];
    String? selectedValue;

    @override
    Future? didChangeDependencies() {
      super.didChangeDependencies();

      // Panggil getAllResponden ketika selectedValue berubah
      if (selectedValue != null) {
        return Responden.getAllResponden(selectedValue);
      }
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(22),
        color: Colors.white,
        child: ListView(
          children: [
            Container(
              child: Row(children: [
                Container(
                  width: 60,
                  height: 60,
                  alignment: Alignment.bottomLeft,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl!),
                    radius: 60,
                    backgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: GoogleFonts.urbanist(
                          color: Color.fromRGBO(63, 62, 62, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      role,
                      style: GoogleFonts.urbanist(
                          color: Color.fromRGBO(106, 112, 124, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ]),
            ),
            SizedBox(
              height: 24,
            ),
            TitleSection(
                title: "Statistic",
                subTitle: "Sistem Informasi Pelaporan Polinema"),
            SizedBox(
              height: 16,
            ),
            TotapResponden(),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(child: RerataUmur()),
                SizedBox(
                  width: 16,
                ),
                Expanded(child: RerataGPA())
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SebaranGender(),
            SizedBox(
              height: 24,
            ),
            TitleSection(
                title: "Berdasarkan Negara",
                subTitle: "Pilih kriteria berdasarkan negara"),
            SizedBox(
              height: 16,
            ),
            DropdownButtonHideUnderline(
                child: DropdownButton2(
              isExpanded: true,
              hint: Text("Select Nation",
                  style: GoogleFonts.urbanist(
                      fontWeight: FontWeight.w600, fontSize: 16)),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w600, fontSize: 16)),
                      ))
                  .toList(),
              value: selectedValue ?? items[0],
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                  print(selectedValue);
                });
              },
              buttonStyleData: ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(247, 248, 249, 1),
                      border: Border.all(
                          color: Color.fromRGBO(232, 236, 244, 1), width: 1),
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  width: double.infinity),
              menuItemStyleData: MenuItemStyleData(height: 40),
            )),
            Container(
                height: 300,
                child: FutureBuilder(
                  future: Responden.getAllResponden(selectedValue),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data['genreList'].length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Card(
                              color: Color.fromRGBO(61, 67, 79, 1),
                              child: ListTile(
                                horizontalTitleGap: 30,
                                leading: Text(
                                  snapshot.data['genreCount']
                                          [snapshot.data['genreList'][index]]
                                      .toString(),
                                  style: GoogleFonts.urbanist(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                ),
                                title: Text(
                                  snapshot.data['genreList'][index].toString(),
                                  style: GoogleFonts.urbanist(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

// Future fetchAPISurvey(String nation) async {
//   Dio dio = Dio();

//   var response = await dio.get('$url/api/responden/nationality/$nation');
//   print("Ini Survey Nation $nation: ${response.data}");
//   return response.data['data'];
// }

class SebaranGender extends StatefulWidget {
  @override
  State<SebaranGender> createState() => _SebaranGenderState();
}

class _SebaranGenderState extends State<SebaranGender> {
  Future<Map<String, dynamic>>? dataGender;

  @override
  void initState() {
    super.initState();
    dataGender = getData();
  }

  Future<Map<String, dynamic>> getData() async {
    final data = await Responden.getSebaranGender();
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: dataGender,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: EdgeInsets.only(top: 15, bottom: 15, right: 21),
                height: 140,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(247, 248, 249, 1),
                    border: Border.all(
                        color: Color.fromRGBO(232, 236, 244, 1), width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      child: GenderPieChart(
                          male: snapshot.data['persentageMale'].toDouble(),
                          female: snapshot.data['persentageFemale'].toDouble()),
                    )),
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sebaran Gender",
                            style: GoogleFonts.urbanist(
                                color: Color.fromRGBO(30, 35, 44, 1),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(106, 112, 124, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              snapshot.data['persentageFemale'].toString() +
                                  "%  Perempuan",
                              style: GoogleFonts.urbanist(
                                  color: Colors.white, fontSize: 14),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: double.infinity,
                            alignment: Alignment.centerLeft,
                            height: 30,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(30, 35, 44, 1),
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              snapshot.data['persentageMale'].toString() +
                                  "%  Laki-Laki",
                              style: GoogleFonts.urbanist(
                                  color: Colors.white, fontSize: 14),
                            ),
                          )
                        ],
                      ),
                    )),
                  ],
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class TotapResponden extends StatelessWidget {
  Future fetchAPI() async {
    Dio dio = Dio();

    var response = await dio.get('$url/api/data-survey');

    return response.data['reponden_all'];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAPI(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(children: [
                  Container(
                    height: 80,
                    color: Color.fromRGBO(30, 35, 44, 1),
                  ),
                  Positioned(
                    left: 190,
                    top: -25,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(61, 67, 79, 1),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 17),
                      child: Text(
                        snapshot.data.toString(),
                        style: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                  Positioned(
                    top: 48,
                    left: 17,
                    child: Text(
                      "Total pengisi survey (Responden)",
                      style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ]),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class RerataUmur extends StatelessWidget {
  Future fetchAPI() async {
    Dio dio = Dio();

    var response = await dio.get('$url/api/data-survey');
    String data = response.data['average_age'].toString();
    double umurDouble = double.parse(data);
    int umur = umurDouble.toInt();
    return umur;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAPI(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 248, 249, 1),
                  border: Border.all(
                      color: Color.fromRGBO(232, 236, 244, 1), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      bottom: 30,
                      child: Text(
                        snapshot.data.toString() + " th",
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                      top: 50,
                      child: Text(
                        "Rerata Umur",
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class RerataGPA extends StatelessWidget {
  Future fetchAPI() async {
    Dio dio = Dio();

    var response = await dio.get('$url/api/data-survey');
    String data = response.data['average_gpa'].toString();
    double gpaDouble = double.parse(data);
    return gpaDouble;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchAPI(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 90,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 248, 249, 1),
                  border: Border.all(
                      color: Color.fromRGBO(232, 236, 244, 1), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      bottom: 30,
                      child: Text(
                        snapshot.data.toStringAsFixed(1),
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                      top: 50,
                      child: Text(
                        "Rerata IPK",
                        style: GoogleFonts.urbanist(
                            color: Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
                color: Color.fromRGBO(30, 35, 44, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            subTitle,
            style: GoogleFonts.urbanist(
                color: Color.fromRGBO(106, 112, 124, 1),
                fontSize: 14,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class GenderPieChart extends StatefulWidget {
  const GenderPieChart({super.key, required this.male, required this.female});

  final double male;
  final double female;

  @override
  State<GenderPieChart> createState() => _GenderPieChartState();
}

class _GenderPieChartState extends State<GenderPieChart> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(sections: [
        PieChartSectionData(
            radius: 20,
            value: widget.male,
            showTitle: false,
            color: Color.fromRGBO(30, 35, 44, 1)),
        PieChartSectionData(
            radius: 20,
            value: widget.female,
            showTitle: false,
            color: Color.fromRGBO(106, 112, 124, 1))
      ]),
      swapAnimationDuration: Duration(milliseconds: 1000),
    );
  }
}
