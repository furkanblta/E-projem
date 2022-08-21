import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testproject/components/header.dart';

import 'category.dart';

class CategoriesPage extends StatelessWidget {
  //const CategoriesPage({Key? key}) : super(key: key);
  final Stream<QuerySnapshot> users =
      FirebaseFirestore.instance.collection('kategoriler').snapshots();

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  CollectionReference furkanRef =
      FirebaseFirestore.instance.collection('kategoriler');

  var gelenYazi = "";
  var gelenIcerik = "";

  List<String> katlist = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            header("Kategoriler", context),

            //burası

            SizedBox(
              height: 16,
            ),
//---------------------------------------------------------------
            Expanded(
              child: Card(child: farkli()),
            )
            //buildCategory(title: gelenIcerik)
          ]))
    ])));
  }

  Widget buildCategory({@required String? title, context, String? test}) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.only(bottom: 16),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 4,
                offset: Offset(0, 4))
          ]),
      child: Text(
        title!,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F1034)),
      ),
    );
  }

  Widget farkli() {
    return StreamBuilder<QuerySnapshot>(
        stream: furkanRef.snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> asyncSnapshot,
        ) {
          if (asyncSnapshot.hasError) {
            return CircularProgressIndicator();
          }
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Text('Loading');
          }
          List<DocumentSnapshot> listOfKat = asyncSnapshot.data!.docs;
          print('${listOfKat[1].get('kategori_ad')}');
          return ListView.builder(
            itemCount: listOfKat.length,
            itemBuilder: (context, index) {
              //  return Text('${listOfKat[index].get('kategori_ad')}');
              return GestureDetector(
                onTap: () {
                  print("buton tıklandı");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryPage(
                              furkan:
                                  '${listOfKat[index].get('kategori_ad')}')));
                },
                child: buildCategory(
                  title: '${listOfKat[index].get('kategori_ad')}',
                  context: '${listOfKat[index].get('kategori_ad')}',
                ),
              );

              //Text('${listOfKat[index].get('kategori_ad')}'));
              // return Text('${listOfKat[index].data() as Map)['kategori_ad']}');
            },
          );
        });
  }
}

Widget buildContent(String title, String photoUrl, String price) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12),
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(6), boxShadow: [
      BoxShadow(
          color: Colors.white.withOpacity(0.08),
          blurRadius: 24,
          offset: Offset(0, 16))
    ]),
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 20,
        ),
        Image.network(
          photoUrl,
          height: 200,
          width: 100,
        ),
        SizedBox(
          height: 18,
        ),
        Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0A1034)),
            ),
            Text(price + "TL",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0001FC))),
          ],
        ),
        SizedBox(
          height: 16,
        )
      ],
    ),
  );
}
