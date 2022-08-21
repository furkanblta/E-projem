import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  //const Test({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> users = FirebaseFirestore.instance
      .collection('urunler')
      .where("urun_kategori", isEqualTo: "Bilgisayar")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Container(child: GetirUrun())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget GetirUrun() {
    return StreamBuilder<QuerySnapshot>(
        stream: users,
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> asyncSnapshot,
        ) {
          List<DocumentSnapshot> listOfKat = asyncSnapshot.data!.docs;
          //print('${listOfKat[index].get('urun_ad')}');
          return ListView.builder(
            itemCount: listOfKat.length,
            itemBuilder: (context, index) {
              //  return Text('${listOfKat[index].get('kategori_ad')}');
              return GestureDetector(
                onTap: () {
                  print('${listOfKat[index].get('urun_ad')}');
                  /*print("buton tıklandı");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CategoryPage(
                              Katisim: '${listOfKat[index].get('urun_ad')}')));*/
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Card(
                      color: Colors.orangeAccent,
                      elevation: 10.0,
                      shadowColor: Colors.deepOrange,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          side: BorderSide(width: 1, color: Colors.white)),

                      //decoration: Decoration(),
                      margin: EdgeInsets.all(10.0),

                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text('${listOfKat[index].get('urun_ad')}'),
                      ),
                    ),
                  ],
                ),
              );

              //Text('${listOfKat[index].get('kategori_ad')}'));
              // return Text('${listOfKat[index].data() as Map)['kategori_ad']}');
            },
          );
        });
  }
}
