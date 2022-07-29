import 'package:app_map_coffee_user/screens/home_ui.dart';
import 'package:app_map_coffee_user/screens/post_reviwe_ui.dart';
import 'package:app_map_coffee_user/screens/star_all_ui.dart';
import 'package:app_map_coffee_user/screens/star_five_ui.dart';
import 'package:app_map_coffee_user/screens/star_four_ui.dart';
import 'package:app_map_coffee_user/screens/star_one_ui.dart';
import 'package:app_map_coffee_user/screens/star_three_ui.dart';
import 'package:app_map_coffee_user/screens/star_two_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ReviweShopUI extends StatefulWidget {
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

  ReviweShopUI(
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
  State<ReviweShopUI> createState() => _ReviweShopUIState();
}

class _ReviweShopUIState extends State<ReviweShopUI> {

  TextEditingController descriptitonCtrl = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รีวิวร้าน ' + '${widget.Location_Name}',
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xff955000)
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFA238),
      ),
      floatingActionButton: buildMessageButton(),
      body: DefaultTabController(
        length: 6,
        child: Container(
          color: Color(0x44FFA238),
          child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  indicatorWeight: 3,
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Creates border
                    color: Color(0xff955000),
                  ),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),
                  tabs: [
                    SizedBox(
                      width: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'All',),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'(5)',),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'(4)',),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'(3)',),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'(2)',),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 60,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          Tab(text:'(1)',),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      StarAllUI(
                        widget.Email
                      ),
                      StarFiveUI(
                        widget.Email
                      ),
                      StarFourUI(
                        widget.Email
                      ),
                      StarThreeUI(
                        widget.Email
                      ),
                      StarTwoUI(
                        widget.Email
                      ),
                      StarOneUI(
                        widget.Email
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessageButton() => FloatingActionButton.extended(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30)
    ),
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xff955000),
    icon: const Icon(FontAwesomeIcons.receipt,),
    label: const Text(
      'เพิ่มรีวิว',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14
    ),),
    elevation: 10,
    onPressed: (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PostReviweUI(
          widget.Email
        ))
      );
    },
  );


}
