import 'package:app_map_coffee_user/screens/show_manu_coffee_all_ui.dart';
import 'package:app_map_coffee_user/screens/show_manu_sweets_ui.dart';
import 'package:flutter/material.dart';


class ShowManuUI extends StatefulWidget {

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

  ShowManuUI(
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
  State<ShowManuUI> createState() => _ShowManuUIState();
}


class _ShowManuUIState extends State<ShowManuUI> {

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'เมนู',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 23,
                color: Color(0xff955000)
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffFFA238),
        ),
        body: Stack(
            children: [
              Container(
                width: wi,
                height: hi,
                color: Color(0xffFFB35C),
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    const TabBar(
                      isScrollable: false,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Color(0xff955000),
                      labelColor: Color(0xff955000),
                      indicatorWeight: 3,
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      ),
                      tabs: [
                        Tab(text: 'เครื่องดื่ม',),
                        Tab(text: 'ของหวาน',),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          ShowManuCoffeeAllUI(
                             widget.id,
                             widget.Image,
                             widget.User_ID,
                             widget.password,
                             widget.Email,
                             widget.Location_Name,
                             widget.Description,
                             widget.Contact,
                             widget.Office_Hours_Open,
                             widget.Office_Hours_close,
                             widget.Latitude,
                             widget.Longitude,
                             widget.Province_ID
                         ),
                          ShowManuSweetCoffeeUI(
                             widget.id,
                             widget.Image,
                             widget.User_ID,
                             widget.password,
                             widget.Email,
                             widget.Location_Name,
                             widget.Description,
                             widget.Contact,
                             widget.Office_Hours_Open,
                             widget.Office_Hours_close,
                             widget.Latitude,
                             widget.Longitude,
                             widget.Province_ID
                         )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ]
        )
    );
  }
}
