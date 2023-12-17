import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/controller/auth.dart';
import 'package:flutter_polinema_digital/widgets/widgets.dart';
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
                    (statusLulus == 0) ? role! : "Alumni $role",
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

            // Title Section Widget
            const TitleSection(
              title: "Dashboard Akademik",
              subTitle: "Sistem Informasi Pelaporan Polinema",
            ),
            const SizedBox(
              height: 16,
            ),

            // Card Total Alumni Widget
            const TotalWidget(data: "akademik"),
            const SizedBox(
              height: 16,
            ),

            // Card Pie Chart Status Akhir Widget
            const CardPieChart(data: "akademik"),
            const SizedBox(
              height: 24,
            ),
            
            // Card Bar Chart Rerata IPK Widget
            const BarChartIPK(),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}

