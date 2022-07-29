import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:path/path.dart' as Path;
import '../servers/api_map_coffee_user.dart';

class PostReviweUI extends StatefulWidget {
  String? email;

  PostReviweUI(this.email);

  @override
  State<PostReviweUI> createState() => _PostReviweUIState();
}

class _PostReviweUIState extends State<PostReviweUI> {

  String? _image;
  String? name;
  String? email;
  double? _rating;

  TextEditingController commentCtrl = TextEditingController(text: '');

  insertRegisterMapCoffeeShop() async{
    bool resultInsertLocation = await apiInsertPostReviwe(
        _image!,
        name.toString(),
        email.toString(),
        commentCtrl.text.trim(),
        _rating!
    );


    if(resultInsertLocation == true)
    {
      ShowResultCommentDialog("บันทึกเรียนร้อยเเล้ว");
    }
    else
    {
      ShowResultCommentDialog("พบปัญหาในการทำงานกรุณาลองใหม่อีกครั้ง");
    }

  }

  ShowResultCommentDialog(String msg) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFB35C),
          title: Center(
            child: Container(
              width: double.infinity,
              color: Color(0xff955000),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'ผลการทำงาน',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg,
                style: const TextStyle(
                    color: Color(0xff955000),
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'ตกลง',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    email = widget.email;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    String email = FirebaseAuth.instance.currentUser!.email!;
    final Stream<QuerySnapshot> _userStrem = FirebaseFirestore.instance
        .collection("mcs_user")
        .where('email', isEqualTo: email)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รีวิว',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xff955000)
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFA238),
      ),
      body: Container(
          color: const Color(0xffFFCC90),
          child: StreamBuilder<QuerySnapshot>(
              stream: _userStrem,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }
                return ListView(
                  padding: EdgeInsets.zero,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    _image = data['image'];
                    name = data['name'];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 30),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircleAvatar(
                                  child: ClipOval(
                                    child: Image.network(
                                      data['image'],
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  '${data['name']}',
                                  style: TextStyle(
                                      inherit: false,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26,
                                      color: Color(0xff955000)
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20, top: 40,bottom: 5),
                          child: Row(
                            children: [
                              Text(
                                'ความคิดเห็น',
                                style: TextStyle(
                                    color: Color(0xff955000),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    inherit: false
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: TextField(
                            textInputAction: TextInputAction.newline,
                            maxLength: 300,
                            maxLines: 5,
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                            scrollPadding: EdgeInsets.all(10),
                            controller: commentCtrl,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                  color: Color(0xff955000),
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                  color: Color(0xff955000),
                                  width: 2.0,
                                ),
                              ),
                              hintText: 'ใส่รีวิวร้านค้า',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),
                              labelStyle: TextStyle(
                                color: Colors.black38,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16)),
                                borderSide: BorderSide(
                                    width: 0,
                                    color: Color(0xff955000)
                                ),
                              ),
                              focusColor: Color(0xff955000),
                            ),
                          ),
                        ),
                        RatingBar.builder(
                          initialRating: 3,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Color(0xff955000),
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                            _rating = rating;
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                            width: wi * 0.4,
                            height: 60,
                            child: ElevatedButton(
                              onPressed: (){
                                insertRegisterMapCoffeeShop();
                              },
                              child: const Text(
                                'โพสต์',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  fontSize: 18
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff955000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)
                                )
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
          )

      ),
    );
  }
}
