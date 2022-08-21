import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunlerSayfa extends StatelessWidget {
  //const UrunlerSayfa({Key? key}) : super(key: key);

  var refUrunler = FirebaseFirestore.instance.collection("urunler");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Expanded(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: refUrunler.snapshots(),
                  builder: (BuildContext context, AsyncSnapshot asyncSnapshot) {
                    List<DocumentSnapshot> katList = asyncSnapshot.data.docs;

                    return Flexible(
                      child: ListView.builder(
                          itemCount: katList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UrunlerSayfa(),
                                      ));
                                },
                                child: ListTile(
                                  title: Text('Kategori'),
                                  subtitle:
                                      Text('${katList[index].get('urun_ad')}'),
                                ),
                              ),
                            );
                          }),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
