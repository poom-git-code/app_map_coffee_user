

import 'dart:async';

import 'package:app_map_coffee_user/screens/show_shop_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import '../blocks/application_bloc.dart';
import 'manu_bar_ui.dart';


class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  LocationData? currentLocation;
  Completer<GoogleMapController> gooController = Completer();

  //สร้างตัวควบคุม Marker
  Set<Marker> gooMarker = {};
  //สร้างตัวควบคุม Circle
  Set<Circle> gooCircle = {};

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  Future _goToMe() async {
    final GoogleMapController controller = await gooController.future;
    currentLocation = await getCurrentLocation();
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(
            currentLocation!.latitude!,
            currentLocation!.longitude!
        ),
        zoom: 16,
      ),
    )
    );

    MarkerId markerId = MarkerId (currentLocation!.latitude!.toString() + currentLocation!.longitude!.toString());
    setState(() {
      gooMarker.add(
        Marker(
          markerId: markerId,
          position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          infoWindow: const InfoWindow(
            title: 'ตำแหน่ง',
            snippet: 'คุณอยู่ตรงนี้',
          ),
        ),

      );
    });

    CircleId circleId = CircleId(currentLocation!.latitude!.toString() + currentLocation!.longitude!.toString());
    setState(() {
      gooCircle.add(
        Circle(
          circleId: circleId,
          center: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          radius: 200.0,
          fillColor: const Color(0x33FF0000),
          strokeColor: Colors.transparent,
          strokeWidth: 1,
        ),
      );
    });
  }

  @override
  void initState() {
    _goToMe();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    final applicationBloc = Provider.of<ApplicationBloc>(context);

    final Stream<QuerySnapshot> _userStrem = FirebaseFirestore.instance
        .collection("mcs_location").snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'หน้าหลัก',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 23,
              color: Color(0xff955000)
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xffFFA238),
      ),
      drawer: MenuBarUi(),
      body: SizedBox(
        width: wi,
        height: hi,
        child: Column(
          children: [
            SizedBox(
              width: wi,
              height: hi * 0.4,
              child: (applicationBloc.currentLocation == null)
                  ? const Center(child: CircularProgressIndicator(),)
                  : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      applicationBloc.currentLocation!.latitude,
                      applicationBloc.currentLocation!.longitude
                  ),
                  zoom: 15,
                ),
                mapType: MapType.terrain,
                markers: gooMarker,
                circles: gooCircle,
                onMapCreated: (GoogleMapController controller) {
                  //เอาตัว controller ที่สร้างมากำหนดให้กับ Google Map นี้
                  gooController.complete(controller);
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                mapToolbarEnabled: false,
                indoorViewEnabled: false,
                buildingsEnabled: false,
                zoomControlsEnabled: false,
              ),
            ),
            SingleChildScrollView(
              child: SizedBox(
                width: wi,
                height: hi * 0.486,
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.separated(
                      // ignore: missing_return
                      separatorBuilder: (context, index){
                        return Container(
                          height: 2,
                          width: double.infinity,
                          color: Color(0xff955000),
                        );
                      },
                      itemBuilder: (context, index){
                        return ListTile(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowShopUI(
                                      (snapshot.data! as QuerySnapshot).docs[index].id.toString(),
                                      (snapshot.data! as QuerySnapshot).docs[index]['Image'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['User_ID'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['password'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Email'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Location_Name'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Description'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Contact'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Office_Hours_Open'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Office_Hours_close'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Latitude'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Longitude'],
                                      (snapshot.data! as QuerySnapshot).docs[index]['Province_ID']
                                    )
                                )
                            );
                          },
                          leading: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.transparent,
                            child: ClipOval(
                              child: FadeInImage.assetNetwork(
                                placeholder: 'assets/images/Coffee_icon.png',
                                image: (snapshot.data! as QuerySnapshot).docs[index]['Image'],
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            (snapshot.data! as QuerySnapshot).docs[index]['Location_Name'],
                          ),
                          subtitle: Text(
                            '${'เปิด ' + (snapshot.data! as QuerySnapshot).docs[index]['Office_Hours_Open']} ปิด ' + (snapshot.data! as QuerySnapshot).docs[index]['Office_Hours_close'],
                          ),
                          trailing:IconButton(
                            icon: const Icon(
                              Icons.arrow_forward_ios,
                              color: Color(0xff955000),
                            ),
                            onPressed: (){

                            },
                          ),
                        );
                      },
                      itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
