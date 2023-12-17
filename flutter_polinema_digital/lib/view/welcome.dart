import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/view/login.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Welcome.png'), fit: BoxFit.fill)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 450,
            height: 200,
            decoration: const BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('assets/Branding.png'))),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const LoginPage(); // Button untuk mengarahkan ke halaman Login Page
                }));
              },
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 22, right: 22),
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 35, 44, 1),
                    borderRadius: BorderRadius.circular(10)),
                child: Text('Login',
                    style: GoogleFonts.urbanist(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold)),
              )),
          const SizedBox(
            height: 87,
          )
        ],
      ),
    );
  }
}
