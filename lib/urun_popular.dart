import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UrunPopularPage extends StatelessWidget {
  //CategoryPage({Key? key}) : super(key: key);
  //CategoriesPage data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            //---------------------------------------------
            //Text(widget.furkan),
            Expanded(child: GetirUrunSales()),
          ],
        ),
      ),
    );
  }

  Widget GetirUrunSales() {
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
                /* buildContentPop(
                    '${listOfKat[index].get('urun_ad')}',
                    '${listOfKat[index].get('urun_resim')}',
                    '${listOfKat[index].get('urun_fiyat')}');*/

                return Card(
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
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          '${listOfKat[index].get('urun_resim')}',
                          height: 100,
                          width: 100,
                        ),
                        Text('${listOfKat[index].get('urun_ad')}'),
                        SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text('${listOfKat[index].get('urun_fiyat')}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}

Widget buildContentPop(String title, String photoUrl, String price) {
  return Container(
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
        Image.network(
          photoUrl,
          height: 200,
          width: 100,
        ),
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
  );
}
