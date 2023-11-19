import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:flutter_polinema_digital/view/addEdit.dart';
import 'package:flutter_polinema_digital/view/detail.dart';
import 'package:flutter_polinema_digital/view/formLapor.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';

String? url = dotenv.env['BASE_URL'];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> items = ["All", "Indonesia", "Soudan", "France"];
  String? selectedValue;
  var data;

  void initState(){
    super.initState();
    getDataFromFirestore();
  }

  Future<void> getDataFromFirestore() async {
  try {
    // Mengakses Firestore instance
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Membuat referensi koleksi "users"
    CollectionReference usersCollection = firestore.collection('users');

    // Mengambil data dari koleksi "users"
    QuerySnapshot querySnapshot = await usersCollection.get();

    // Memproses data yang diambil
    querySnapshot.docs.forEach((doc) {
      // Mendapatkan data dari dokumen
      String name = doc['name'];
      String email = doc['email'];
      String imageUrl = doc['imageUrl'];
      String role = doc['role'];

      // Lakukan sesuatu dengan data, misalnya tampilkan dalam log
      print('Name: $name, Email: $email, ImageURL: $imageUrl, role: $role');
    });
  } catch (e) {
    print('Error getting data from Firestore: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    //Get Data Responden

    print(name);
    print(email);
    print(role);


    return Scaffold(
      body: Stack(alignment: Alignment.bottomRight, children: [
        Container(
          padding: const EdgeInsets.all(22),
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
                  const SizedBox(
                    width: 14,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name!,
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(63, 62, 62, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        role!,
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ]),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleSection(
                      title: "Statistic",
                      subTitle: "Sistem Informasi Pelaporan Polinema"),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddEditResponden()));
                    },
                    style: ElevatedButton.styleFrom(
                        alignment: Alignment.center,
                        backgroundColor: Color.fromRGBO(30, 35, 44, 1),
                        foregroundColor: Color.fromRGBO(98, 106, 122, 1),
                        fixedSize: Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              TotapResponden(),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(child: RerataUmur()),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(child: RerataGPA())
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SebaranGender(),
              const SizedBox(
                height: 24,
              ),
              const TitleSection(
                title: "Berdasarkan Negara",
                subTitle: "Pilih kriteria berdasarkan negara",
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2(
                  isExpanded: true,
                  hint: Text(
                    "Select Nation",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  items: items
                      .map(
                        (String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(item,
                              style: GoogleFonts.urbanist(
                                  fontWeight: FontWeight.w600, fontSize: 16)),
                        ),
                      )
                      .toList(),
                  value: selectedValue,
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      if (value == "All") {
                        selectedValue = null;
                      } else {
                        selectedValue = value;
                      }
                    });
                  },
                  buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 248, 249, 1),
                        border: Border.all(
                            color: const Color.fromRGBO(232, 236, 244, 1),
                            width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 50,
                      width: double.infinity),
                  menuItemStyleData: const MenuItemStyleData(height: 40),
                ),
              ),
              Container(
                height: 400,
                child: FutureBuilder(
                  future: Responden.getAllResponden(selectedValue),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container(
                        child: const Center(
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
                              color: const Color.fromRGBO(61, 67, 79, 1),
                              child: ListTile(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          nation: selectedValue,
                                          genre: snapshot.data['genreList']
                                                  [index]
                                              .toString())));
                                },
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
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 30, right: 25),
          child: FloatingActionButton.extended(
            backgroundColor: Color.fromRGBO(239, 68, 68, 1),
            foregroundColor: Colors.black,
            onPressed: () {
              // Respond to button press
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LaporPage()));
            },
            icon: Icon(
              Icons.favorite,
              color: Colors.white,
            ),
            label: Text(
              'Lapor Pelecehan',
              style: GoogleFonts.urbanist(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ),
        )
      ]),
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Responden.getDataStatistic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
                padding: const EdgeInsets.only(top: 15, bottom: 15, right: 21),
                height: 140,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(247, 248, 249, 1),
                    border: Border.all(
                        color: const Color.fromRGBO(232, 236, 244, 1),
                        width: 1),
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  children: [
                    Expanded(
                        child: GenderPieChart(
                            male: snapshot.data['persentageMale'].toDouble(),
                            female:
                                snapshot.data['persentageFemale'].toDouble())),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sebaran Gender",
                          style: GoogleFonts.urbanist(
                              color: const Color.fromRGBO(30, 35, 44, 1),
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          height: 30,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(106, 112, 124, 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "${snapshot.data['persentageFemale']}%  Perempuan",
                            style: GoogleFonts.urbanist(
                                color: Colors.white, fontSize: 14),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          height: 30,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(30, 35, 44, 1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            "${snapshot.data['persentageMale']}%  Laki-Laki",
                            style: GoogleFonts.urbanist(
                                color: Colors.white, fontSize: 14),
                          ),
                        )
                      ],
                    )),
                  ],
                ));
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class TotapResponden extends StatelessWidget {
  const TotapResponden({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Responden.getDataStatistic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Stack(children: [
                  Container(
                    height: 80,
                    color: const Color.fromRGBO(30, 35, 44, 1),
                  ),
                  Positioned(
                    left: 190,
                    top: -25,
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(61, 67, 79, 1),
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 8, left: 17),
                      child: Text(
                        snapshot.data["totalResponden"].toString(),
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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class RerataUmur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Responden.getDataStatistic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 90,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(247, 248, 249, 1),
                  border: Border.all(
                      color: const Color.fromRGBO(232, 236, 244, 1), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      bottom: 30,
                      child: Text(
                        snapshot.data["rerataUmur"].toString() + " th",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                      top: 50,
                      child: Text(
                        "Rerata Umur",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class RerataGPA extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Responden.getDataStatistic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: 90,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(247, 248, 249, 1),
                  border: Border.all(
                      color: const Color.fromRGBO(232, 236, 244, 1), width: 1),
                  borderRadius: BorderRadius.circular(8)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                      bottom: 30,
                      child: Text(
                        snapshot.data['rerataGpa'].toStringAsFixed(1),
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                      top: 50,
                      child: Text(
                        "Rerata IPK",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ],
              ),
            );
          } else {
            return const Center(
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
    this.widget,
  });

  final String title;
  final String subTitle;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.urbanist(
                color: const Color.fromRGBO(30, 35, 44, 1),
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          Text(
            subTitle,
            style: GoogleFonts.urbanist(
                color: const Color.fromRGBO(106, 112, 124, 1),
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
            color: const Color.fromRGBO(30, 35, 44, 1)),
        PieChartSectionData(
            radius: 20,
            value: widget.female,
            showTitle: false,
            color: const Color.fromRGBO(106, 112, 124, 1))
      ]),
      swapAnimationDuration: const Duration(milliseconds: 1000),
    );
  }
}
