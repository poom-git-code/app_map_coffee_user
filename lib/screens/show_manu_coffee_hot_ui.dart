import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ShowManuCoffeeHotUI extends StatefulWidget {

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

  ShowManuCoffeeHotUI(
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
  State<ShowManuCoffeeHotUI> createState() => _ShowManuCoffeeHotUIState();
}

class _ShowManuCoffeeHotUIState extends State<ShowManuCoffeeHotUI> {
  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;
    final Stream<QuerySnapshot> _userStrem = FirebaseFirestore.instance
        .collection("mcs_product")
        .where('email_id', isEqualTo: widget.Email)
        .where('type', isEqualTo: '0')
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'เมนู ร้อน',
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
          SingleChildScrollView(
            child: Container(
              color: const Color(0x44FFA238),
              width: wi,
              height: hi,
              child: Padding(
                padding: EdgeInsets.only(top: hi * 0.02),
                child: StreamBuilder(
                  stream: _userStrem,
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
                                          height: wi * 0.35,
                                          fit: BoxFit.fitHeight,
                                        ),
                                        SizedBox(height: wi * 0.025,),
                                        Text("${(snapshot.data! as QuerySnapshot).docs[index]['manuname']}" +
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
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2
                      ),

                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
