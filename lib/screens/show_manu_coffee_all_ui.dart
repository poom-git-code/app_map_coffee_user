import 'package:app_map_coffee_user/screens/show_manu_coffee_cool.dart';
import 'package:app_map_coffee_user/screens/show_manu_coffee_hot_ui.dart';
import 'package:app_map_coffee_user/screens/show_manu_coffee_mold.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowManuCoffeeAllUI extends StatefulWidget {

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

  ShowManuCoffeeAllUI(
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
  State<ShowManuCoffeeAllUI> createState() => _ShowManuCoffeeAllUIState();
}

class _ShowManuCoffeeAllUIState extends State<ShowManuCoffeeAllUI> {

  late int count;

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    final Stream<QuerySnapshot> _manuhotStrem = FirebaseFirestore.instance
        .collection("mcs_product")
        .where('email_id', isEqualTo: widget.Email)
        .where('type', isEqualTo: '0')
        .snapshots();
    final Stream<QuerySnapshot> _manucoolStrem = FirebaseFirestore.instance
        .collection("mcs_product")
        .where('email_id', isEqualTo: widget.Email)
        .where('type', isEqualTo: '1')
        .snapshots();
    final Stream<QuerySnapshot> _manumoldStrem = FirebaseFirestore.instance
        .collection("mcs_product")
        .where('email_id', isEqualTo: widget.Email)
        .where('type', isEqualTo: '2')
        .snapshots();

    Widget ManuHot() => Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: wi * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color(0xff955000),
                width: wi * 0.05,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mugHot,
                      color: Color(0xff955000),
                    ),
                    SizedBox(width: wi * 0.01,),
                    Text(
                      'ร้อน',
                      style: TextStyle(
                          color: Color(0xff955000),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff955000),
                width: wi * 0.65,
                height: 2,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: hi * 0.03, left: wi * 0.8),
          child: TextButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowManuCoffeeHotUI(
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
            child: Text(
              'ดูทั้งหมด',
              style: TextStyle(
                  color: Color(0xff955000)
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: wi * 0.12),
          child: SizedBox(
            width: wi,
            height: hi * 0.28,
            child: Padding(
              padding: EdgeInsets.only(top: hi * 0.02),
              child: StreamBuilder(
                stream: _manuhotStrem,
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
                  if((snapshot.data! as QuerySnapshot).docs.length == 5){
                    count = 5;
                  }else{
                    count = (snapshot.data! as QuerySnapshot).docs.length;
                  }
                  return GridView.builder(
                    // ignore: missing_return
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: Stack(
                          children: [
                            Center(
                              child: Material(
                                color: Colors.white,
                                elevation: 7,
                                borderRadius: BorderRadius.circular(30),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: InkWell(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage((snapshot.data! as QuerySnapshot).docs[index]['image']),
                                        width: wi * 0.82,
                                        height: wi * 0.3,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      SizedBox(height: wi * 0.025,),
                                      Text(
                                        "${(snapshot.data! as QuerySnapshot).docs[index]['manuname']}" +
                                            "   ${(snapshot.data! as QuerySnapshot).docs[index]['price']} บ.",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      SizedBox(height: 7,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: count,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 1 / 1,
                      // crossAxisSpacing: 10,
                      // mainAxisSpacing: 10
                    ),
                    scrollDirection: Axis.horizontal,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );

    Widget ManuCool() => Padding(
      padding: EdgeInsets.only(top: hi * 0.05, bottom: hi * 0.05),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color(0xff955000),
                width: wi * 0.05,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.mugSaucer,
                      color: Color(0xff955000),
                      size: 23,
                    ),
                    SizedBox(width: wi * 0.02,),
                    Text(
                      'เย็น',
                      style: TextStyle(
                          color: Color(0xff955000),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff955000),
                width: wi * 0.65,
                height: 2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: hi * 0.03, left: wi * 0.8),
            child: TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowManuCoffeeCoolUI(
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
                    )
                );
              },
              child: Text(
                'ดูทั้งหมด',
                style: TextStyle(
                    color: Color(0xff955000)
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: hi * 0.07),
            child: SizedBox(
              width: wi,
              height: hi * 0.28,
              child: Padding(
                padding: EdgeInsets.only(top: hi * 0.02),
                child: StreamBuilder(
                  stream: _manucoolStrem,
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
                    if((snapshot.data! as QuerySnapshot).docs.length == 5){
                      count = 5;
                    }else{
                      count = (snapshot.data! as QuerySnapshot).docs.length;
                    }
                    return GridView.builder(
                      // ignore: missing_return
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Center(
                                child: Material(
                                  color: Colors.white,
                                  elevation: 7,
                                  borderRadius: BorderRadius.circular(30),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Ink.image(
                                          image: NetworkImage((snapshot.data! as QuerySnapshot).docs[index]['image']),
                                          width: wi * 0.82,
                                          height: wi * 0.3,
                                          fit: BoxFit.fitHeight,
                                        ),
                                        SizedBox(height: wi * 0.025,),
                                        Text(
                                          "${(snapshot.data! as QuerySnapshot).docs[index]['manuname']}" +
                                              "   ${(snapshot.data! as QuerySnapshot).docs[index]['price']} บ.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 7,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: count,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 1,
                        // crossAxisSpacing: 10,
                        // mainAxisSpacing: 10
                      ),
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Widget ManuMold() => Padding(
      padding: EdgeInsets.only(bottom: hi * 0.05),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Color(0xff955000),
                width: wi * 0.05,
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.beerMugEmpty,
                      color: Color(0xff955000),
                    ),
                    SizedBox(width: wi * 0.01,),
                    Text(
                      'ปั้น',
                      style: TextStyle(
                          color: Color(0xff955000),
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color(0xff955000),
                width: wi * 0.65,
                height: 2,
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: hi * 0.03, left: wi * 0.8),
            child: TextButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ShowManuCoffeeMoldUI(
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
              child: Text(
                'ดูทั้งหมด',
                style: TextStyle(
                    color: Color(0xff955000)
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: hi * 0.07),
            child: SizedBox(
              width: wi,
              height: hi * 0.28,
              child: Padding(
                padding: EdgeInsets.only(top: hi * 0.02),
                child: StreamBuilder(
                  stream: _manumoldStrem,
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
                    if((snapshot.data! as QuerySnapshot).docs.length == 5){
                      count = 5;
                    }else{
                      count = (snapshot.data! as QuerySnapshot).docs.length;
                    }
                    return GridView.builder(
                      // ignore: missing_return
                      itemBuilder: (context, index){
                        return Padding(
                          padding: const EdgeInsets.all(5),
                          child: Stack(
                            children: [
                              Center(
                                child: Material(
                                  color: Colors.white,
                                  elevation: 7,
                                  borderRadius: BorderRadius.circular(30),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: InkWell(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Ink.image(
                                          image: NetworkImage((snapshot.data! as QuerySnapshot).docs[index]['image']),
                                          width: wi * 0.82,
                                          height: wi * 0.3,
                                          fit: BoxFit.fitHeight,
                                        ),
                                        SizedBox(height: wi * 0.025,),
                                        Text(
                                          "${(snapshot.data! as QuerySnapshot).docs[index]['manuname']}" +
                                              "   ${(snapshot.data! as QuerySnapshot).docs[index]['price']} บ.",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                        SizedBox(height: 7,),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: count,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 1,
                        // crossAxisSpacing: 10,
                        // mainAxisSpacing: 10
                      ),
                      scrollDirection: Axis.horizontal,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if(_manuhotStrem == null){

    }else{

    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Color(0x44FFA238),
          child: Column(
            children: [
              ManuHot(),
              ManuCool(),
              ManuMold(),
            ],
          ),
        ),
      ),
    );
  }
}
