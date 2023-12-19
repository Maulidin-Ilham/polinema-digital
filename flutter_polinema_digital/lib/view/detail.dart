import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, this.nation, required this.genre});

  final String? nation;
  final String genre;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _scrollController = ScrollController();
  List<Map<String, dynamic>> listResponden = [];
  List<Map<String, dynamic>> displayData = [];
  bool isLoading = false;
  int currentPage = 1;
  int pageSize = 15;
  int lengthAllData = 0;

  @override
  void initState() {
    super.initState();

    if (listResponden.isEmpty) {
      displayData = [];
      getDetailData(widget.nation, widget.genre);
    } else {
      displayData = [];
      displayData = listResponden.sublist(0, pageSize);
    }

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (displayData.length < listResponden.length) {
          int endIndex = displayData.length + pageSize;
          if (endIndex > listResponden.length) {
            endIndex = listResponden.length;
          }
          Timer(const Duration(seconds: 1), () {
            setState(() {
              displayData
                  .addAll(listResponden.sublist(displayData.length, endIndex));
            });
          });
        }
      }
    });
  }

  Future<void> getDetailData(String? nation, String genre) async {
    String? url = dotenv.env['BASE_URL'];
    Dio dio = Dio();
    print("$nation dengan genre $genre");

    try {
      if (nation == null || nation.isEmpty) {
        String uri = "$url/api/responden/nationality/$nation";
        var response = await dio.get(uri);
        final data = response.data['data'];
        final count = response.data['count'];
        print("Jumlah data $count");

        //Tidak menampilkan apa apa
      } else {
        String uri = "$url/api/responden/nationality/$nation/$genre";
        var response = await dio.get(uri);
        if (response.statusCode == 200) {
          final data = response.data['data'];
          lengthAllData = response.data['count'];

          setState(() {
            int startIndex = (currentPage - 1) * pageSize;
            print(data);
            print("Panjang listResponden $lengthAllData");

            if (listResponden.length == 0) {
              listResponden.addAll(List<Map<String, dynamic>>.from(data));
              print("Data berhasil dimasukkan ke listResponden");
            }

            print(listResponden.length);

            if (startIndex < listResponden.length) {
              if (listResponden.length < 15) {
                displayData.addAll(
                    listResponden.sublist(startIndex, listResponden.length));
              } else {
                displayData.addAll(listResponden.sublist(startIndex, 15));
              }
            }

            isLoading = false;
            currentPage++;
          });
          listResponden.addAll(List<Map<String, dynamic>>.from(data));
        }
      }
    } catch (e) {
      print('Kesalahan saat mengurai JSON: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 22, right: 22, bottom: 22, top: 40),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.genre}",
                  style: GoogleFonts.urbanist(
                      color: const Color.fromRGBO(30, 35, 44, 1),
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                widget.nation != null
                    ? Text(
                        "Detail Survei Negara ${widget.nation}",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      )
                    : Text(
                        "Detail Survei Dari Seluruh Negara",
                        style: GoogleFonts.urbanist(
                            color: const Color.fromRGBO(106, 112, 124, 1),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: displayData.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < displayData.length) {
                        return Card(
                          color: const Color.fromRGBO(249, 249, 255, 1),
                          shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  color: Color.fromRGBO(232, 234, 238, 1)),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 10),
                            child: ListTile(
                              leading: Text(
                                (index + 1).toString(),
                                style: GoogleFonts.urbanist(
                                    color: const Color.fromRGBO(106, 112, 124, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              title: Text(
                                displayData[index]['reports'],
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.urbanist(
                                    color: const Color.fromRGBO(106, 112, 124, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        );
                      } else {
                        if (displayData.length >= lengthAllData) {
                          return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Text(
                              "End of Data",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                  color: const Color.fromRGBO(106, 112, 124, 1),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          );
                        } else {
                          return const Padding(
                            padding: EdgeInsets.all(10),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailResponden extends StatefulWidget {
  const DetailResponden({super.key, this.nation, required this.genre});
  final String? nation;
  final String genre;

  @override
  State<DetailResponden> createState() => _DetailRespondenState();
}

class _DetailRespondenState extends State<DetailResponden> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const Text("Data1"),
        const Text("Data1"),
        const Text("Data1"),
      ],
    );
  }
}
