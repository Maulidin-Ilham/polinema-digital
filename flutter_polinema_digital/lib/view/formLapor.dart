import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/laporan.dart';
import 'package:flutter_polinema_digital/view/report.dart';
import 'package:flutter_polinema_digital/widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';

class LaporPage extends StatefulWidget {
  const LaporPage({super.key});

  @override
  State<LaporPage> createState() => _LaporPageState();
}

class _LaporPageState extends State<LaporPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  final TextEditingController _nohpController = TextEditingController();
  final TextEditingController _kronologiController = TextEditingController();

  String selectedJenisLaporan = "Pelecehan Seksual";
  TextEditingController otherJenisLaporan = TextEditingController();
  bool showOtherInput = false;

  String? imagePath;
  File? buktiImage;
  bool _isDataFetched = false;

  static const List<String> listJenisLaporan = <String>[
    "Pelecehan Seksual",
    "Kekerasan",
    "Other"
  ];

  bool isNumeric(String value) {
    if (value == null) {
      return false;
    }
    return double.tryParse(value) != null;
  }

  Future<void> fetchData(String email) async {
    if (!_isDataFetched) {
      String? url = dotenv.env['BASE_URL'];
      Dio dio = Dio();
      String uri = "$url/api/user/find/$email";

      Response response = await dio.get(uri);

      if (response.statusCode == 200) {
        List<dynamic> userList = response.data['user'];
        if (userList.isNotEmpty) {
          Map<String, dynamic> userData = userList[0];
          setState(() {
            _nameController.text = userData['name'];
            _nimController.text = userData['nim'].toString();
            _nohpController.text = userData['nohp'];
          });
        }
      } else {
      }
    }
    setState(() {
      _isDataFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = _auth.currentUser;
    String? userEmail = user?.email;

    fetchData(userEmail!);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 50),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // TITLE PAGE
               const TitleSection(
                  title: "Lapor Pelecehan",
                  subTitle: 'Sistem Informasi Pelaporan Polinema'),
              const SizedBox(
                height: 50,
              ),
              // END OF TITLE PAGE

              // INPUT AGE
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'NIM',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _nimController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(232, 236, 244, 50),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0, // Lebar border saat terfokus
                              color: Color.fromRGBO(
                                  61, 67, 79, 1) // Warna border saat terfokus
                              ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(232, 236, 244, 1))),
                        filled: true,
                        focusColor: Color.fromRGBO(247, 248, 249, 1),
                        fillColor: Color.fromRGBO(247, 248, 249, 1),
                        hintText: "Enter your NIM",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your NIM';
                        } else if (value.length != 10 || !isNumeric(value)) {
                          return 'NIM lenght must be 10 numbers';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT AGE

              // INPUT NAME
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nama',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // INPUT NAME
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Color.fromRGBO(232, 236, 244, 50),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0, // Lebar border saat terfokus
                              color: Color.fromRGBO(
                                  61, 67, 79, 1) // Warna border saat terfokus
                              ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(232, 236, 244, 1))),
                        filled: true,
                        focusColor: Color.fromRGBO(247, 248, 249, 1),
                        fillColor: Color.fromRGBO(247, 248, 249, 1),
                        hintText: "Enter your full name",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT NAME

              // INPUT PHONE NUMBER
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nomor HP',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // INPUT NIM
                    TextFormField(
                      controller: _nohpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 0.5,
                            color: Colors.red,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: 2.0, // Lebar border saat terfokus
                              color: Color.fromRGBO(
                                  61, 67, 79, 1) // Warna border saat terfokus
                              ),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(232, 236, 244, 1))),
                        filled: true,
                        focusColor: Color.fromRGBO(247, 248, 249, 1),
                        fillColor: Color.fromRGBO(247, 248, 249, 1),
                        hintText: "Enter your phone number",
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if ((value.length != 13 ||
                                !isNumeric(value)) &&
                            (value.startsWith("62"))) {
                          return 'number phone lenght must be 13 numbers and start with 62';
                        } else {
                          return null;
                        }
                      },
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT NAME

              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jenis Laporan',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                          color: const Color.fromRGBO(247, 248, 249, 1),
                          border: Border.all(
                              color: const Color.fromRGBO(232, 236, 244, 1),
                              width: 1),
                          borderRadius: BorderRadius.circular(8)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: selectedJenisLaporan,
                          dropdownColor: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          items: listJenisLaporan
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: GoogleFonts.urbanist(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(
                              () {
                                selectedJenisLaporan = newValue!;
                                showOtherInput = newValue == "Other";
                              },
                            );
                          },
                        ),
                      ),
                    )
                  ]),
              const SizedBox(
                height: 15,
              ),
              //END OF SELECT Jenis Laporan

              // INPUT JENIS LAPORAN LAINNYA
              Visibility(
                visible: showOtherInput,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jenis Laporan Lainnya',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      // INPUT NAME
                      TextFormField(
                        controller: otherJenisLaporan,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 0.5,
                              color: Color.fromRGBO(232, 236, 244, 50),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 2.0, // Lebar border saat terfokus
                                color: Color.fromRGBO(61, 67, 79,
                                    1) // Warna border saat terfokus
                                ),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(232, 236, 244, 1))),
                          filled: true,
                          focusColor: Color.fromRGBO(247, 248, 249, 1),
                          fillColor: Color.fromRGBO(247, 248, 249, 1),
                          hintText: "Enter your other report type",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter other report type';
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT JENIS LAPORAN LAINNYA

              // INPUT REPORTS
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Kronologi',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _kronologiController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color.fromRGBO(232, 236, 244, 1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                                width: 2.0, // Lebar border saat terfokus
                                color: Color.fromRGBO(61, 67, 79,
                                    1) // Warna border saat terfokus
                                ),
                          ),
                          filled: true,
                          focusColor: Color.fromRGBO(247, 248, 249, 1),
                          fillColor: Color.fromRGBO(247, 248, 249, 1),
                          hintText: "Enter your Report",
                          hintStyle: TextStyle(color: Colors.grey)),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the Report';
                        }
                        return null;
                      },
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT REPORTS

              // INPUT NAME
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bukti',
                      style: GoogleFonts.urbanist(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    // INPUT NAME
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(247, 248, 249, 1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: const Color.fromRGBO(232, 236, 244, 1),
                            width: 1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            (imagePath == null) ? "Choose Image" : imagePath!,
                            style: GoogleFonts.urbanist(
                                color: const Color.fromRGBO(131, 145, 161, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                side: const BorderSide(
                                    color: Color.fromRGBO(232, 236, 244, 1),
                                    width: 2),
                                elevation: 0,
                                padding: const EdgeInsets.all(15),
                                backgroundColor: Colors.white,
                                surfaceTintColor: Colors.white),
                            onPressed: () async {
                              // File? imageFile = await getImage();
                              // setState(() {
                              //   if (imageFile != null) {
                              //     buktiImage = imageFile;
                              //     imagePath = basename(imageFile.path);
                              //   } else {
                              //     print("Gagal memilih gambar");
                              //   }
                              // });
                            },
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Color.fromRGBO(131, 145, 161, 1),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  ]),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT NAME

              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      LaporanServices.create_laporan(
                          _nimController.text,
                          _nameController.text,
                          _nohpController.text,
                          selectedJenisLaporan,
                          otherJenisLaporan.text,
                          _kronologiController.text,
                          buktiImage!);


                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const ReportPage();
                        },
                      ));
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(30, 35, 44, 1),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text('Submit',
                        style: GoogleFonts.urbanist(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

