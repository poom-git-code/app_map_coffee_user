import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarAllUI extends StatefulWidget {

  String? Email;

  StarAllUI(this.Email);

  @override
  State<StarAllUI> createState() => _StarAllUIState();
}

class _StarAllUIState extends State<StarAllUI> {
  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    int _con;

    final Stream<QuerySnapshot> _manuStrem = FirebaseFirestore.instance
        .collection("mcs_comment")
        .where('EmailPath', isEqualTo: widget.Email)
        .snapshots();

    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 50),
      child: StreamBuilder(
        stream: _manuStrem,
        builder: (context, snapshot){
          if(snapshot.hasError)
          {
            return const Center(
              child: Text('พบข้อผิดพลาดกรุณาลองใหม่อีกครั้ง'),
            );
          }
          if(snapshot.connectionState == ConnectionState.waiting)
          {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "กรุณารอสักครู่",
                    style: TextStyle(
                        color: Color(0xff955000),
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Center(
                  child: CircularProgressIndicator(
                    color: Color(0xff955000),
                  ),
                ),
              ],
            );
          }
          return ListView.separated(
            // ignore: missing_return
            separatorBuilder: (context, index){
              return Container(
                height: 2,
                width: double.infinity,
                color: Colors.transparent,
              );
            },
            itemBuilder: (context, index){
              return SingleChildScrollView(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      topLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )
                  ),
                  color: Color(0xffC16800),
                  child: SizedBox(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 15,left: 15),
                                child: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircleAvatar(
                                    child: ClipOval(
                                      child: Image.network(
                                        (snapshot.data as QuerySnapshot).docs[index]['Image'],
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20,left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${(snapshot.data as QuerySnapshot).docs[index]['Name']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: RatingBar.builder(
                                        initialRating: (snapshot.data as QuerySnapshot).docs[index]['StarType'],
                                        minRating: 1,
                                        itemSize: 18,
                                        direction: Axis.horizontal,
                                        itemCount: 5,
                                        itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                                        itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                        ),
                                        onRatingUpdate: (rating) {
                                          print(rating);
                                          _con = rating as int;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                width: wi,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Text(
                                    '${(snapshot.data as QuerySnapshot).docs[index]['Comment']}',
                                    style: TextStyle(
                                      color: Colors.white
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                )
              );
            },
            itemCount: (snapshot.data! as QuerySnapshot).docs.length,
          );
        },
      ),
    );
  }
}
