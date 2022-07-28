import 'package:app_map_coffee_user/screens/show_manu_coffee_cool.dart';
import 'package:app_map_coffee_user/screens/show_manu_coffee_hot_ui.dart';
import 'package:app_map_coffee_user/screens/show_manu_coffee_mold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectManuPage extends StatefulWidget {

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

  SelectManuPage(
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
  State<SelectManuPage> createState() => _SelectManuPageState();
}

class _SelectManuPageState extends State<SelectManuPage> {

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xffFFBD71),
        backgroundColor: Color(0xff955000),
        unselectedItemColor: Colors.grey.shade300,
        selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600
        ),
        unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600
        ),
        currentIndex: _currentIndex,
        onTap: (index){
          if(index == 1){
            setState(() {
              _currentIndex = index;
            });
          }
          else{
            setState(() {
              _currentIndex = index;
            });
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mugHot),
            label: "ร้อน",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.free_breakfast),
            label: "เย็น",
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.beerMugEmpty),
            label: "ปั้น",
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
      body: getBodyWidget(),
    );
  }
  getBodyWidget() {
    if(_currentIndex == 0){
      return ShowManuCoffeeHotUI(
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
      );
    }else if(_currentIndex == 1){
      return ShowManuCoffeeCoolUI(
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
      );
    }
    else{
      return ShowManuCoffeeMoldUI(
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
      );
    }
  }
}
