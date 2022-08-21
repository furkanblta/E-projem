import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/header.dart';

class UrunDetayPage extends StatefulWidget {
  //const UrunDetayPage({Key? key}) : super(key: key);

  String Urun = "";

  UrunDetayPage({required this.Urun});

  @override
  State<UrunDetayPage> createState() => _UrunDetayPageState();
}

class _UrunDetayPageState extends State<UrunDetayPage> {
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
                  header(widget.Urun, context),

                  //---------------------------------------------
                  //Text(widget.furkan),

                  const SizedBox(
                    height: 8,
                  ),

                  Container(
                    child: Column(
                      children: [getirUrunSales()],
                    ),
                  )
                ],
              ),
            ),
            //bottomNavigationBar(),
          ],
        ),
      ),
    );
  }

  Widget getirUrunSales() {
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('urunler')
        .where("urun_ad", isEqualTo: widget.Urun)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: users,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot> snapshot,
      ) {
        if (snapshot.hasError) {
          return Text('Something went wrong.');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading');
        }

        final data = snapshot.requireData;
        int fiyat = 0;
        return Container(
          child: Column(
            children: [
              Image.network(
                '${data.docs[0]['urun_resim']}',
                height: 300,
                width: 400,
              ),
              const SizedBox(
                height: 3,
              ),
              Text(' ${data.docs[0]['urun_ad']}',
                  style: TextStyle(fontSize: 28, color: Colors.black38)),
              const SizedBox(
                height: 10,
              ),
              Text(' ${data.docs[0]['urun_fiyat']}' + " TL",
                  style: TextStyle(fontSize: 18, color: Color(0xFFd32f2f))),
              SizedBox(
                height: 150,
              ),
              GestureDetector(
                onTap: () async {
                  final userNAme = FirebaseAuth.instance.currentUser!;
                  fiyat = int.parse(' ${data.docs[0]['urun_fiyat']}');
                  String adAl = ' ${data.docs[0]['urun_ad']}';
                  String urunResim = '${data.docs[0]['urun_resim']}';

                  CollectionReference _sepetAt =
                      FirebaseFirestore.instance.collection('sepet');
                  return _sepetAt.doc().set({
                    'urun_ad': adAl,
                    'urun_fiyat': fiyat,
                    'userName': userNAme.email!,
                    'urun_resim': urunResim
                  });
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Color(0xFFd32f2f),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                      child: Text(
                    "Sepete Ekle",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  )),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
