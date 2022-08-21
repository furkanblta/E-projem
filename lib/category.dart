import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testproject/UrunDetay.dart';
import 'package:testproject/components/header.dart';

class CategoryPage extends StatelessWidget {
  //CategoryPage({Key? key}) : super(key: key);
  //CategoriesPage data;

  String furkan = "";

  CategoryPage({required this.furkan});

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
                  header(furkan + " Kategorisi", context),
                  SizedBox(
                    height: 32,
                  ),

                  //---------------------------------------------
                  //Text(widget.furkan),
                  GetirUrun(),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget GetirUrun() {
    final Stream<QuerySnapshot> users = FirebaseFirestore.instance
        .collection('urunler')
        .where("urun_kategori", isEqualTo: furkan)
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
          //print('${listOfKat[index].get('urun_ad')}');
          return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1),
              itemCount: listOfKat.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UrunDetayPage(
                                Urun: '${listOfKat[index].get('urun_ad')}')));
                  },
                  child: buildContent(
                      '${listOfKat[index].get('urun_ad')}',
                      '${listOfKat[index].get('urun_resim')}',
                      '${listOfKat[index].get('urun_fiyat')}'),
                );
              },
            ),
          );
        });
  }
}

Widget buildContent(String title, String photoUrl, String price) {
  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.08),
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
            height: 80,
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
    ),
  );
}
