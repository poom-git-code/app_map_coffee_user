import 'package:app_map_coffee_user/models/map_coffee_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/reviwe_shop.dart';

Future<bool> apiInsertUser(String Image ,String User_ID, String password, String Name, String Email) async{

  //สร้าง object เพื่อนไปเก็บที่ firestore database
  MapCoffeeUser timeline = MapCoffeeUser(
      image: Image,
      userID: User_ID,
      password: password,
      name: Name,
      email: Email,
  );

  //นำ object แปลงเป็น json แล้วส่งไปที่ firestore database
  try{
    await FirebaseFirestore.instance.collection("mcs_user").add(timeline.toJson());
    return true;
  }catch(ex){
    return false;
  }
}
Stream<QuerySnapshot>? apiGetAlluser(){
  try{
    return FirebaseFirestore.instance.collection('mcs_user').snapshots();
  }catch(ex){
    return null;
  }
}
//------------------------------------------------------------------------------------------------------------
Future<bool> apiUpdateUser(String id,String Image ,String User_ID, String password, String Name, String Email) async{

  //สร้าง object เพื่อนไปเก็บที่ firestore database
  MapCoffeeUser timeline = MapCoffeeUser(
    image: Image,
    userID: User_ID,
    password: password,
    name: Name,
    email: Email,
  );

  //นำ object แปลงเป็น json แล้วส่งไปที่ firestore database
  try{
    await FirebaseFirestore.instance.collection("mcs_user").doc(id).update(timeline.toJson());
    return true;
  }catch(ex){
    return false;
  }
}
//------------------------------------------------------------------------------------------------------------
Future<bool> apiInsertPostReviwe(String Image ,String Name, String EmailPath, String Comment, double StarType) async{

  //สร้าง object เพื่อนไปเก็บที่ firestore database
  ReviweShop timeline = ReviweShop(
    image: Image,
    name: Name,
    emailPath: EmailPath,
    comment: Comment,
    starType: StarType
  );

  //นำ object แปลงเป็น json แล้วส่งไปที่ firestore database
  try{
    await FirebaseFirestore.instance.collection("mcs_comment").add(timeline.toJson());
    return true;
  }catch(ex){
    return false;
  }
}
Stream<QuerySnapshot>? apiGetAllPostReviwe(){
  try{
    return FirebaseFirestore.instance.collection('mcs_comment').snapshots();
  }catch(ex){
    return null;
  }
}
//-