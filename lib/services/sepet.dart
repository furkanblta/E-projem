import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/header.dart';

class SepetPage extends StatelessWidget {
  //const SepetPage({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;
  int toplamFiyat = 0;
  int fiyat = 0;

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
        body: SafeArea(
            child: Stack(children: [
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            header("Sepetim", context),
            SizedBox(
              height: 16,
            ),
            GetirUrun(),
            Text(toplamFiyat.toString()),
          ]))
    ])));
  }

  Widget GetirUrun() {
    final user = FirebaseAuth.instance.currentUser!;
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('sepet')
        .where("userName", isEqualTo: user.email!)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: users,
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

          return Expanded(
            child: ListView.builder(
              itemCount: listOfKat.length,
              itemBuilder: (context, index) {
                fiyat =
                    int.parse('${listOfKat[index].get('urun_fiyat')}') + fiyat;
                toplamFiyat = fiyat;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black45.withOpacity(0.08),
                                blurRadius: 24,
                                offset: Offset(0, 16)),
                          ],
                          color: Colors.white),
                      height: 100,
                      width: 800,
                      child: Row(
                        children: [
                          Expanded(
                            child: Image.network(
                              '${listOfKat[index].get('urun_resim')}',
                              height: 100,
                              width: 200,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${listOfKat[index].get('urun_ad')}',
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${listOfKat[index].get('urun_fiyat')}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          );
        });
  }
}
