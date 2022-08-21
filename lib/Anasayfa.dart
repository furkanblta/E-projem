import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testproject/UrunDetay.dart';
import 'package:testproject/categories.dart';
import 'package:testproject/login.dart';
import 'package:testproject/urun_popular.dart';

class AnasayfaPage extends StatefulWidget {
  const AnasayfaPage({Key? key}) : super(key: key);

  @override
  State<AnasayfaPage> createState() => _AnasayfaPageState();
}

class _AnasayfaPageState extends State<AnasayfaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Başlık
                  buildBaslik(),

                  //Banner

                  buildBanner(),

                  //Butonlar

                  Padding(
                    padding: const EdgeInsets.only(top: 48),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        buildNavigation(
                            text: "Kategoriler",
                            icon: Icons.menu,
                            widget: CategoriesPage(),
                            context: context),
                        buildNavigation(
                            text: "Favoriler",
                            icon: Icons.star,
                            widget: UrunPopularPage(),
                            context: context),
                        buildNavigation(
                          text: "Sepetim",
                          icon: Icons.shopping_cart,
                        ),
                        buildNavigation(
                            text: "En çoklar",
                            icon: Icons.person,
                            widget: LoginPage(),
                            context: context),
                      ],
                    ),
                  ),

                  //Sales Title

                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "En Popüler ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF0A1034)),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  // Sales Item

                  //GetirUrun(),

                  Expanded(child: getirUrunSales()),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            //bottomNavigationBar(),
            //NavBarPage(),
          ],
        ),
      ),
    );
  }
}

Widget buildBaslik() {
  return Padding(
    padding: const EdgeInsets.only(top: 24.0),
    child: Text(
      "Anasayfa",
      style: TextStyle(
          fontSize: 32, color: Color(0xFF0A1034), fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildBanner() {
  return Padding(
    padding: EdgeInsets.only(top: 24.0),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 24, right: 36, top: 14, bottom: 18),
      decoration: BoxDecoration(
          color: Color(0xFFd32f2f), borderRadius: BorderRadius.circular(6)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bose Home Speaker",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 4),
              Text(
                "216 TL",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Image.asset(
            "images/speaker.png",
            height: 57,
            width: 78,
          ),
        ],
      ),
    ),
  );
}

Widget buildNavigation(
    {@required String? text,
    @required IconData? icon,
    Widget? widget,
    BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context!, MaterialPageRoute(builder: (context) {
        return widget!;
      }));
    },
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xFFd32f2f)),
          child: Icon(
            icon!,
            color: Colors.white,
            size: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          text!,
          style: TextStyle(
              color: Color(0xFFd32f2f),
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget getirUrunSales() {
  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('urunler')
      .where("urun_popular", isEqualTo: true)
      .snapshots();

  return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> asyncSnapshot,
      ) {
        if (asyncSnapshot.hasError) {
          return const CircularProgressIndicator();
        }
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading');
        }

        List<DocumentSnapshot> listOfKat = asyncSnapshot.data!.docs;
        //print('${listOfKat[index].get('urun_ad')}');
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 1),
          itemCount: listOfKat.length,
          itemBuilder: (context, index) {
            return Card(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UrunDetayPage(
                              Urun: '${listOfKat[index].get('urun_ad')}')));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 24,
                            offset: const Offset(0, 16))
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        '${listOfKat[index].get('urun_resim')}',
                        height: 100,
                        width: 100,
                      ),
                      Text('${listOfKat[index].get('urun_ad')}'),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text('${listOfKat[index].get('urun_fiyat')}' + " TL"),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
}
