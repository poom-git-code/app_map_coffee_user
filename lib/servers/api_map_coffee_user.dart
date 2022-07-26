import 'package:app_map_coffee_user/models/map_coffee_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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