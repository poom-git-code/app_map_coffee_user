import 'package:app_map_coffee_user/screens/show_image_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowShopUI extends StatefulWidget {

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

  ShowShopUI(
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
  State<ShowShopUI> createState() => _ShowShopUIState();
}

class _ShowShopUIState extends State<ShowShopUI> {

  double latitude = 0;
  double longitude = 0;


  @override
  void initState() {
    latitude = widget.Latitude;
    longitude = widget.Longitude;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.Location_Name,
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
        width: wi,
        height: hi,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: wi,
                height: hi * 0.4,
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/images/Coffee_icon.png',
                  image: widget.Image,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: hi * 0.02, bottom: hi * 0.02),
              child: SizedBox(
                width: wi,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: wi * 0.3,
                      height: hi * 0.1,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff955000),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 5
                        ),
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowImageUI(
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
                            )
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.solidImage,
                              size: 30,
                            ),
                            SizedBox(width: wi * 0.03,),
                            const Text(
                              'รูปภาพ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: wi * 0.03,),
                    SizedBox(
                      width: wi * 0.3,
                      height: hi * 0.1,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff955000),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 5
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.mugHot,
                              size: 30,
                            ),
                            SizedBox(width: wi * 0.03,),
                            const Text(
                              'เมนู',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: wi * 0.03,),
                    SizedBox(
                      width: wi * 0.3,
                      height: hi * 0.1,
                      child: ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff955000),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 5
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              FontAwesomeIcons.commentDots,
                              size: 30,
                            ),
                            SizedBox(width: wi * 0.03,),
                            const Text(
                              'รีวิว',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: wi * 0.02),
              child: SizedBox(
                width: wi,
                height: hi * 0.1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff955000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      elevation: 5
                  ),
                  onPressed: (){},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        FontAwesomeIcons.mapLocation,
                        size: 35,
                      ),
                      SizedBox(width: wi * 0.05,),
                      const Text(
                        'เปิด Google Map',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
      );
  }
}
