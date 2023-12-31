import 'package:flutter/material.dart';
import 'package:flutter_polinema_digital/view/akademi.dart';
import 'package:flutter_polinema_digital/view/report.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, this.user, this.statusUser});
  final user;
  final statusUser;


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final page = [
    const AkademikPage(),
    const ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NAVBAR
      body: page[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        elevation: 12,
        backgroundColor: Colors.white,
        selectedItemColor: const Color.fromRGBO(30, 35, 44, 1),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.insert_chart), label: "Dashboard"),
          BottomNavigationBarItem(icon: Icon(Icons.description_rounded), label: "Laporan"),
        ],
        onTap: (index) {
          setState(() {
          _currentIndex = index;
          });
        },
      ),
    );
  }
}