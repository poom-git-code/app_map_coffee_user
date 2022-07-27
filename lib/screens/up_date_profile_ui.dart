import 'dart:io';

import 'package:app_map_coffee_user/models/map_coffee_user.dart';
import 'package:app_map_coffee_user/screens/home_ui.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;
import '../models/ShapesPainter.dart';
import '../servers/api_map_coffee_user.dart';

class UpdateProfileUI extends StatefulWidget {

  String id;
  String image;
  String? name;
  String? email;
  String? password;
  String? userID;

  UpdateProfileUI(
      this.id,
      this.image,
      this.name,
      this.email,
      this.password,
      this.userID
      );

  @override
  State<UpdateProfileUI> createState() => _UpdateProfileUIState();
}

class _UpdateProfileUIState extends State<UpdateProfileUI> {

  File? _image;
  bool pwValue = false;
  MapCoffeeUser mapCoffeeUser = MapCoffeeUser();

  TextEditingController userCtrl = TextEditingController(text: '');
  TextEditingController passwordCtrl = TextEditingController(text: '');
  TextEditingController confirmpasswordCtrl = TextEditingController(text: '');
  TextEditingController nameCtrl = TextEditingController(text: '');
  TextEditingController emailCtrl = TextEditingController(text: '');

  showBottomSheetForSelectImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          color: Color(0xffFFC079),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 28.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showSelectImageFromCamera();
                    },
                    style: TextButton.styleFrom(
                      primary: Color(0xff955000),
                    ),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('กล้อง'),
                  ),
                ),
                const SizedBox(
                  width: 16.0,
                ),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      showSelectImageFormGallery();
                    },
                    style: TextButton.styleFrom(
                      primary: Color(0xff8C00A4),
                    ),
                    icon: const Icon(Icons.camera),
                    label: const Text('แกลอรี่'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  showSelectImageFromCamera() async {
    PickedFile? imageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 75,
    );
    if (imageFile == null) return;
    setState(() {
      _image = File(imageFile.path);
    });
  }

  showSelectImageFormGallery() async {
    PickedFile? imageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );
    if (imageFile == null) return;
    setState(() {
      _image = File(imageFile.path);
    });
  }

  showWarningDialog(String msg) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Container(
              width: double.infinity,
              color: Color(0xff955000),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'คำเตือน',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg,
                style: const TextStyle(
                    color: Color(0xff955000),
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'ตกลง',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Color(0xffFFB35C),
        );
      },
    );
  }

  showConfirmUpdateDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFB35C),
          title: Center(
            child: Container(
              width: double.infinity,
              color: Color(0xff955000),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'ยืนยัน',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'ต้องการแก้ไขบัญชีผู้ใช้หรือไม่ ?',
                style: TextStyle(
                    color: Color(0xff955000),
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          updateRegisterMapCoffeeShop();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'ตกลง',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'ยกเลิก',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ShowResultUpdateDialog(String msg) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xffFFB35C),
          title: Center(
            child: Container(
              width: double.infinity,
              color: Color(0xff955000),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                ),
                child: Text(
                  'ผลการทำงาน',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                msg,
                style: const TextStyle(
                    color: Color(0xff955000),
                    fontWeight: FontWeight.bold
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeUI()
                              ),
                              (route) => false
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          padding: const EdgeInsets.symmetric(
                            vertical: 12.0,
                          ),
                        ),
                        child: const Text(
                          'ตกลง',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  updateRegisterMapCoffeeShop() async{
    if(_image != null){
      String imageName = Path.basename(_image!.path);

      //อัปโหลดรุปไปที่ storage ที่ firebase
      Reference ref =  FirebaseStorage.instance.ref().child('Picture_user_tb/' + imageName);
      UploadTask uploadTask = ref.putFile(_image!);
      //เมื่ออัปโหลดรูปเสร็จเราจะได้ที่อยู่ของรูป แล้วเราก็จะส่งที่อยู่อยู่ของรูปไปพร้อมกับข้อมูลอื่นๆ ไปเก็บที่ Firestore Database ของ Firebase
      uploadTask.whenComplete(() async{
        String imgeUrl = await ref.getDownloadURL();

        bool resultInsertFriend = await apiUpdateUser(
          widget.id,
          imgeUrl,
          userCtrl.text.trim(),
          passwordCtrl.text.trim(),
          nameCtrl.text.trim(),
          FirebaseAuth.instance.currentUser!.email!,
        );
        if(resultInsertFriend == true)
        {
          ShowResultUpdateDialog("บันทึกเการแก้ไขเรียบร้อยเเล้ว");
        }
        else
        {
          ShowResultUpdateDialog("พบปัญหาในการทำงานกรุณาลองใหม่อีกครั้ง");
        }
      });
    }else{
      bool resultInsertManu = await apiUpdateUser(
          widget.id,
          widget.image,
          userCtrl.text.trim(),
          passwordCtrl.text.trim(),
          nameCtrl.text.trim(),
        FirebaseAuth.instance.currentUser!.email!,
      );
      if(resultInsertManu == true)
      {
        ShowResultUpdateDialog("บันทึกการแก้ไขเมนูเรียบร้อยเเล้ว");
      }
      else
      {
        ShowResultUpdateDialog("พบปัญหาในการทำงานกรุณาลองใหม่อีกครั้ง");
      }
    }
  }

  @override
  void initState() {
    emailCtrl.text = widget.email!;
    passwordCtrl.text = widget.password!;
    userCtrl.text = widget.userID!;
    nameCtrl.text = widget.name!;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'สมัครสมาชิก',
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
            height: hi,
            width: wi,
            color: const Color(0xffFFBD71),
          ),
          Container(
            width: wi,
            height: hi,
            child: CustomPaint(  /*ใช้ในการสร้างตัวเรขาคณิต โดยที่ต้องไปสร้าง class ใหม่*/
              painter: ShapesPainter(),
            ),
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 100.0,
                          backgroundColor: Color(0xffFFB35C),
                          child: ClipOval(
                            child: SizedBox(
                              width: 180.0,
                              height: 180.0,
                              child: _image != null
                                  ?
                              Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              )
                                  :
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/images/User-group-icon.png',
                                image: widget.image,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: IconButton(
                            onPressed: () {
                              showBottomSheetForSelectImage(context);
                            },
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 30.0,
                              color: Color(0xff955000),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),//กล้อง
                  Padding(
                    padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20),
                    child: TextField(
                      controller: emailCtrl,
                      enabled: false,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Color(0xff955000),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 2.0,
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 3.0
                          ),
                        ),
                        hintText: 'ใส่อีเมล',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelText: 'อีเมล',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),//email
                  Padding(
                    padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20),
                    child: TextField(
                      controller: userCtrl,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Color(0xff955000),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 2.0,
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 3.0
                          ),
                        ),
                        hintText: 'ใส่ชื่อผู้ใช้',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelText: 'ชื่อผู้ใช้   ',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),//user
                  Padding(
                    padding: EdgeInsets.only(right: 40.0, left: 40.0, top: 20),
                    child: TextField(
                      controller: nameCtrl,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.accessibility,
                          color: Color(0xff955000),
                        ),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 2.0,
                            )
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color(0xff955000),
                              width: 3.0
                          ),
                        ),
                        hintText: 'ใส่ชื่อเล่น',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        labelText: 'ชื่อเล่น',
                        labelStyle: TextStyle(
                          color: Colors.black38,
                        ),
                      ),
                    ),
                  ),//name
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 30, top: 30, bottom: 40),
                    child: Container(
                      width: wi,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (){
                          if(userCtrl.text.trim().length == 0){
                            showWarningDialog('กรุณาใส่ชื่อผู้ใช้ด้วย!!!');
                          }
                          else if(nameCtrl.text.trim().length == 0){
                            showWarningDialog('กรุณาใส่ชื่อเล่นด้วย!!!');
                          }
                          else if(emailCtrl.text.trim().length == 0){
                            showWarningDialog('กรุณาใส่อีเมลด้วย!!!');
                          }
                          else{
                            try{
                              showConfirmUpdateDialog();
                            }catch(e){
                              showWarningDialog('เกิดข้อผิดพลาดกรุณาลองใหม่อีกครั้ง');
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff955000)
                        ),
                        child: const Text(
                          'แก้ไข',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),
                        ),
                      ),
                    ),
                  ),//bottom
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
