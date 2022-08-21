import 'package:flutter/material.dart';
import 'package:testproject/Anasayfa.dart';
import 'package:testproject/categories.dart';
import 'package:testproject/person.dart';
import 'package:testproject/services/sepet.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String test = "";

  List sayfaListesi = [
    const AnasayfaPage(),
    CategoriesPage(),
    SepetPage(),
    PersonPage()
  ];

  int secilenIndeks = 0;

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: sayfaListesi[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: Color(0xFFd32f2f),
        unselectedItemColor: Colors.black54.withOpacity(0.5),
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded), label: 'Anasayfa'),
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Kategoriler'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.shopping_bag,
              ),
              label: 'Sepet'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
