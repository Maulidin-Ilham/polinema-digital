import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/controller/akademikAPI.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return Column(
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
    );
  }
}

// Card Total Widget
class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: (data == "akademik")
            ? Akademik.getDataAkademik()
            : Responden.getDataStatistic(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ClipRRect(
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
                      (data == "akademik")
                          ? snapshot.data["allStudent"].toString()
                          : snapshot.data["totalResponden"].toString(),
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
                    (data == "akademik")
                        ? "Total Alumni Polinema"
                        : "Total pengisi survey (Responden)",
                    style: GoogleFonts.urbanist(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ]),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

// Card Pie Chart Widget
class CardPieChart extends StatefulWidget {
  const CardPieChart({super.key, required this.data});
  final String data;

  @override
  State<CardPieChart> createState() => _StatusAkhirState();
}

class _StatusAkhirState extends State<CardPieChart> {
  Future<Map<String, dynamic>>? dataGender;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: (widget.data == "akademik")
            ? Akademik.getDataAkademik()
            : Responden.getDataStatistic(),
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
                    child: PieChartWidget(
                      a: (widget.data == "akademik")
                          ? snapshot.data['studentLulus'].toDouble()
                          : snapshot.data['persentageMale'].toDouble(),
                      b: (widget.data == "akademik")
                          ? snapshot.data['studentTidakLulus'].toDouble()
                          : snapshot.data['persentageFemale'].toDouble(),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (widget.data == "akademik") ? "Status Akhir" : "Sebaran Gender",
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
                          (widget.data == "akademik") ? "${snapshot.data['studentLulus']}% Lulus" : "${snapshot.data['persentageFemale']}%  Perempuan",
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
                          (widget.data == "akademik") ? "${snapshot.data['studentTidakLulus']}% Tidak lulus" : "${snapshot.data['persentageMale']}%  Laki-Laki",
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

// Pie Chart Widget
class PieChartWidget extends StatefulWidget {
  const PieChartWidget({super.key, required this.a, required this.b});

  final double a;
  final double b;

  @override
  State<PieChartWidget> createState() => _GenderPieChartState();
}

class _GenderPieChartState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(sections: [
        PieChartSectionData(
            radius: 20,
            value: widget.a,
            showTitle: false,
            color: const Color.fromRGBO(30, 35, 44, 1)),
        PieChartSectionData(
            radius: 20,
            value: widget.b,
            showTitle: false,
            color: const Color.fromRGBO(106, 112, 124, 1))
      ]),
      swapAnimationDuration: const Duration(milliseconds: 1000),
    );
  }
}


// Card Bar Chart IPK Widget
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
                  SizedBox(
                    height: 50,
                    child: Text(
                      "Rerata IPK",
                      style: GoogleFonts.urbanist(
                          color: const Color.fromRGBO(0, 0, 0, 1),
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
                                  color: const Color.fromRGBO(30, 35, 44, 1),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8))),
                            ],
                          ),
                      ],
                      borderData: FlBorderData(
                        border: const Border(
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
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
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


// Card mini Information
class CardInformation extends StatelessWidget {
  final String title;
  final String data;
  const CardInformation({super.key, required this.title, required this.data});

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
                        (data == "umur") ? "${snapshot.data["rerataUmur"]} th" : snapshot.data['rerataGpa'].toStringAsFixed(1),
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(30, 35, 44, 1),
                            fontSize: 32,
                            fontWeight: FontWeight.w700),
                      )),
                  Positioned(
                      top: 50,
                      child: Text(
                        title,
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