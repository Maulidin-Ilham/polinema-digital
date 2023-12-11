import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/controller/akademikAPI.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:flutter_polinema_digital/view/report.dart';
import 'package:google_fonts/google_fonts.dart';

class AkademikPage extends StatefulWidget {
  const AkademikPage({super.key, this.user, this.statusUser});
  final user;
  final statusUser;

  @override
  State<AkademikPage> createState() => _AkademikPageState();
}

class _AkademikPageState extends State<AkademikPage> {
  String? selectedValue;
  var data;

  @override
  Widget build(BuildContext context) {
    print(name);
    print(email);
    print(role);
    print("statusLulus : $statusLulus");
    final status = (statusLulus == 1) ? "Lulus" : "Belum Lulus";
    print("status User : $status");

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(22),
        color: Color.fromARGB(255, 241, 242, 245),
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
                      (statusLulus == 0) ? role! : "Alumni $role",
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
            const TitleSection(
              title: "Dashboard Akademik",
              subTitle: "Sistem Informasi Pelaporan Polinema",
            ),
            const SizedBox(
              height: 16,
            ),
            TotapResponden(),
            const SizedBox(
              height: 16,
            ),
            StatusAkhir(),
            const SizedBox(
              height: 24,
            ),
            BarChartIPK(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

class StatusAkhir extends StatefulWidget {
  const StatusAkhir({super.key});

  @override
  State<StatusAkhir> createState() => _StatusAkhirState();
}

class _StatusAkhirState extends State<StatusAkhir> {
  Future<Map<String, dynamic>>? dataGender;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Akademik.getDataAkademik(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              padding: const EdgeInsets.only(top: 15, bottom: 15, right: 21),
              height: 140,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(247, 248, 249, 1),
                border: Border.all(
                    color: const Color.fromRGBO(232, 236, 244, 1), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                      child: GenderPieChart(
                          male: snapshot.data['studentLulus'].toDouble(),
                          female:
                              snapshot.data['studentTidakLulus'].toDouble())),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status Akhir",
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
                          "${snapshot.data['studentLulus']}% Lulus",
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
                          "${snapshot.data['studentTidakLulus']}% Tidak lulus",
                          style: GoogleFonts.urbanist(
                              color: Colors.white, fontSize: 14),
                        ),
                      )
                    ],
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

class BarChartIPK extends StatefulWidget {
  const BarChartIPK({super.key});

  @override
  State<BarChartIPK> createState() => _BarChartIPKState();
}

class _BarChartIPKState extends State<BarChartIPK> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BarChartGroupData>>(
        future: Akademik.getIPKBar(),
        builder: (BuildContext context,
            AsyncSnapshot<List<BarChartGroupData>> snapshot) {
          if (snapshot.hasData) {
            return Container(

              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 15),
              height: 300,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(247, 248, 249, 1),
                border: Border.all(
                    color: const Color.fromRGBO(232, 236, 244, 1), width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    child: Text(
                      "Rerata IPK",
                      style: GoogleFonts.urbanist(
                          color: Color.fromRGBO(0, 0, 0, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    child: BarChart(BarChartData(
                      barGroups: [
                        for (int i = 0; i < snapshot.data!.length; i++)
                          BarChartGroupData(
                            x: i,
                            barRods: [
                              BarChartRodData(
                                  fromY: 3,
                                  toY: snapshot.data![i].barRods[0].toY
                                      .toDouble(),
                                  width: 40,
                                  color: Color.fromRGBO(30, 35, 44, 1),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                            ],
                          ),
                      ],
                      borderData: FlBorderData(
                        border: Border(
                          top: BorderSide.none,
                          right: BorderSide.none,
                          left: BorderSide.none,
                          bottom: BorderSide(width: 1),
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: AxisTitles(
                            sideTitles: _bottomTitles
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  SideTitles get _bottomTitles => SideTitles(
    showTitles: true,
    getTitlesWidget: (value, meta) {
      String text = '';
      switch (value.toInt()) {
        case 0:
          text = '2018';
          break;
        case 1:
          text = '2019';
          break;
        case 2:
          text = '2020';
          break;
        case 3:
          text = '2021';
          break;
      }

      return Text(text);
    },
  );
}

class TotapResponden extends StatelessWidget {
  const TotapResponden({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Akademik.getDataAkademik(),
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
                        snapshot.data["allStudent"].toString(),
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
                      "Total Alumni Polinema",
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
