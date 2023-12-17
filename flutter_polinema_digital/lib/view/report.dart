import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/controller/responden.dart';
import 'package:flutter_polinema_digital/view/addEdit.dart';
import 'package:flutter_polinema_digital/view/detail.dart';
import 'package:flutter_polinema_digital/view/formLapor.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_polinema_digital/widgets/widgets.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key, this.user, this.statusUser});
  final user;
  final statusUser;

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final List<String> items = ["All", "Indonesia", "Soudan", "France"];
  String? selectedValue;
  var data;

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
          color: const Color.fromARGB(255, 241, 242, 245),
          child: ListView(
            children: [
              // HEADER (User information)
              Row(children: [
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
                      (widget.statusUser == 0) ? role! : "Alumni $role",
                      style: GoogleFonts.urbanist(
                          color: const Color.fromRGBO(106, 112, 124, 1),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ]),
              const SizedBox(
                height: 24,
              ),

              // Title Section with Button add Keluhan
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const TitleSection(
                    title: "Statistic",
                    subTitle: "Sistem Informasi Pelaporan Polinema",
                  ),
                  if (statusLulus == 0)
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const AddEditResponden()));
                      },
                      style: ElevatedButton.styleFrom(
                          alignment: Alignment.center,
                          backgroundColor: const Color.fromRGBO(30, 35, 44, 1),
                          foregroundColor: const Color.fromRGBO(98, 106, 122, 1),
                          fixedSize: const Size.fromHeight(48),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              // Card Total Responden Keluhan Widget
              const TotalWidget(data: "responden"),
              const SizedBox(
                height: 16,
              ),

              // Card UMUR dan IPK Widget
              const Row(
                children: [
                  Expanded(child: CardInformation(title: "Rerata Umur", data: "umur")),
                  SizedBox(
                    width: 16,
                  ),
                  Expanded(child: CardInformation(title: "Rerata IPK", data: "ipk"))
                ],
              ),
              const SizedBox(
                height: 16,
              ),

              // Card Pie Chart Sebaran Gender Widget
              const CardPieChart(
                data: "responden",
              ),
              const SizedBox(
                height: 24,
              ),

              // Title Section Filter by Nation
              const TitleSection(
                title: "Berdasarkan Negara",
                subTitle: "Pilih kriteria berdasarkan negara",
              ),
              const SizedBox(
                height: 16,
              ),

              // Dropdown Filter by Nation
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

              SizedBox(
                height: 400,
                child: FutureBuilder(
                  future: Responden.getAllResponden(selectedValue),
                  builder: (context, snapshot) {

                    // list Genre by Nation
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
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

        // Button Lapor Pelecehan
        if (statusLulus == 0)
          Padding(
            padding: const EdgeInsets.only(bottom: 30, right: 25),
            child: FloatingActionButton.extended(
              backgroundColor: const Color.fromRGBO(239, 68, 68, 1),
              foregroundColor: Colors.black,
              onPressed: () {
                // Respond to button press
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => const LaporPage()));
              },
              icon: const Icon(
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