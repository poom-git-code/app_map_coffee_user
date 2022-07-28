import 'package:app_map_coffee_user/screens/show_image_max_size.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import 'package:transparent_image/transparent_image.dart';

class ShowImageUI extends StatefulWidget {

  String id;
  String Image;
  String? User_ID;
  String? password;
  String? Email;
  String Location_Name;
  String? Description;
  String? Contact;
  String? Office_Hours_Open;
  String? Office_Hours_close;
  double Latitude;
  double Longitude;
  String? Province_ID;

  ShowImageUI(
      this.id,
      this.Image,
      this.User_ID,
      this.password,
      this.Email,
      this.Location_Name,
      this.Description,
      this.Contact,
      this.Office_Hours_Open,
      this.Office_Hours_close,
      this.Latitude,
      this.Longitude,
      this.Province_ID
      );

  @override
  State<ShowImageUI> createState() => _ShowImageUIState();
}

class _ShowImageUIState extends State<ShowImageUI> {

  String? email;

  @override
  void initState() {
    email = widget.Email!;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> _userStrem = FirebaseFirestore.instance
        .collection("mcs_imagesShop")
        .where('Email', isEqualTo: email)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รูปภาพ',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xff955000)
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFA238),
      ),
      body: Container(
        color: Color(0x44FFA238),
        child: StreamBuilder(
          stream: _userStrem,
          builder: (context, snapshot) {
            return !snapshot.hasData
                ?
            const Center(
              child: CircularProgressIndicator(),
            )
                :
            Container(
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2
                ),
                itemBuilder: (context, index) {
                  return GridTile(
                    footer: SingleChildScrollView(
                      child: SizedBox(
                        width: wi,
                        height: hi,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ShowimageMaxSize(
                                          (snapshot.data! as QuerySnapshot).docs[index].id.toString(),
                                          (snapshot.data! as QuerySnapshot).docs[index]['Email'],
                                          (snapshot.data! as QuerySnapshot).docs[index]['url'],
                                        )
                                )
                            );
                          },
                          child: Text(''),
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.0),
                      child: FadeInImage.memoryNetwork(
                        fit: BoxFit.cover,
                        placeholder: kTransparentImage,
                        image: (snapshot.data! as QuerySnapshot).docs[index].get('url'),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}