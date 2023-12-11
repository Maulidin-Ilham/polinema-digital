import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polinema_digital/controller/getData.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:flutter_polinema_digital/view/home.dart';
import 'package:flutter_polinema_digital/view/report.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEditResponden extends StatefulWidget {
  const AddEditResponden({super.key});

  @override
  State<AddEditResponden> createState() => _AddEditRespondenState();
}

class _AddEditRespondenState extends State<AddEditResponden> {
  final _formKey = GlobalKey<FormState>();

  static const List<String> gender = <String>['Male', 'Female'];
  static const List<String> nation = <String>["Indonesia", "Soudan", "France"];
  List<String> genre = [];

  var _selectedGender = gender.first;
  var _selectedNation = nation.first;
  var _selectedGenre;
  TextEditingController _ageController = TextEditingController();
  TextEditingController _gpaController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _reportsControler = TextEditingController();

  void fetchAllGenre() async {
    genre = await Responden.getAllGenre();
    print(genre);
  }

  @override
  Widget build(BuildContext context) {
    fetchAllGenre();

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 50),
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // TITLE PAGE
              TitleSection(
                  title: "Add Response",
                  subTitle: 'Sistem Informasi Pelaporan Polinema'),
              SizedBox(
                height: 50,
              ),
              // END OF TITLE PAGE

              // INPUT AGE
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Age',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _ageController,
                        keyboardType: TextInputType.number,
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
                            hintText: "Enter your Age",
                            hintStyle: TextStyle(color: Colors.grey)),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Age';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT AGE

              // INPUT GPA
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'GPA',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _gpaController,
                        keyboardType: TextInputType.number,
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
                            hintText: "Enter your GPA",
                            hintStyle: TextStyle(color: Colors.grey)),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your GPA';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT GPA

              // INPUT YEAR
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Year',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _yearController,
                        keyboardType: TextInputType.number,
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
                            hintText: "Enter your Year",
                            hintStyle: TextStyle(color: Colors.grey)),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Year';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              //END OF INPUT YEAR

              //SELECT GENDER
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 248, 249, 1),
                            border: Border.all(
                                color: Color.fromRGBO(232, 236, 244, 1),
                                width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedGender,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              items: gender.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedGender = value!;
                                });
                              }),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              //END OF SELECT GENDER

              //SELECT NATION
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nation',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 248, 249, 1),
                            border: Border.all(
                                color: Color.fromRGBO(232, 236, 244, 1),
                                width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isExpanded: true,
                              value: _selectedNation,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              items: nation.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedNation = value!;
                                });
                              }),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              //END OF SELECT NATION

              //SELECT GENRE
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Genre',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(247, 248, 249, 1),
                          border: Border.all(
                              color: Color.fromRGBO(232, 236, 244, 1),
                              width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                              isExpanded: true,
                              hint: Text(
                                "Choose Genre",
                                style: GoogleFonts.urbanist(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              value: _selectedGenre,
                              dropdownColor: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              items: genre.map<DropdownMenuItem<String>>(
                                  (String value) {
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
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedGenre = value;
                                });
                              }),
                        ),
                      )
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              //END OF SELECT GENRE

              // INPUT REPORTS
              Container(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Report',
                        style: GoogleFonts.urbanist(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: _reportsControler,
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
                        },
                      ),
                    ]),
              ),
              const SizedBox(
                height: 15,
              ),
              // END OF INPUT REPORTS

              TextButton(
                  style: ButtonStyle(
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent)),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, you can process the login.
                      Responden.create_responden(
                          _ageController.text,
                          _gpaController.text,
                          _yearController.text,
                          _selectedGender,
                          _selectedNation,
                          _selectedGenre,
                          _reportsControler.text);

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return ReportPage();
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