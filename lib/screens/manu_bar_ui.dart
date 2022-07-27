import 'dart:io';

import 'package:app_map_coffee_user/screens/login_ui.dart';
import 'package:app_map_coffee_user/screens/up_date_profile_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

class MenuBarUi extends StatefulWidget {
  const MenuBarUi({super.key});


  @override
  State<MenuBarUi> createState() => _MenuBarUiState();
}

class _MenuBarUiState extends State<MenuBarUi> {
  final auth = FirebaseAuth.instance;
  File? _image;

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

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    String email = FirebaseAuth.instance.currentUser!.email!;
    final Stream<QuerySnapshot> _userStrem = FirebaseFirestore.instance
        .collection("mcs_user")
        .where('email', isEqualTo: email)
        .snapshots();

    return Drawer(
        backgroundColor: const Color(0xffB8B8B8),
        child: StreamBuilder<QuerySnapshot>(
            stream: _userStrem,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return Container(
                width: wi,
                height: hi,
                color: Color(0x66FFA238),
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    return Column(
                      children: [
                        UserAccountsDrawerHeader(
                          accountName: Text(
                            data['name'],
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                          accountEmail: Text(
                            auth.currentUser!.email!,
                            style: TextStyle(
                              color: Colors.black
                            ),
                          ),
                          currentAccountPicture: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                data['image'],
                                width: 90,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://media.istockphoto.com/photos/yellow-coffee-grinder-with-a-bag-of-beans-and-a-coffee-cup-an-saucer-picture-id1168225732?k=20&m=1168225732&s=612x612&w=0&h=k64ercFkQxLrJP2sWyHNwmtVeSymemsuTL5Uo4FFiRE=',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 2,),
                        Container(
                          color: Colors.white,
                          width: wi,
                          child: ListTile(
                            // tileColor: Colors.white,
                            leading: const Icon(Icons.edit, color: Colors.black,),
                            title: const Text(
                              'แก้ไขข้อมูลส่วนตัว',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                MaterialPageRoute(builder: (context){
                                  return UpdateProfileUI(
                                    document.id,
                                    data['image'],
                                    data['name'],
                                    data['email'],
                                    data['password'],
                                    data['userID']
                                  );
                                }
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 10,),
                        Container(
                          width: wi,
                          color: Color(0xffE37373),
                          child: ListTile(
                            // tileColor: const Color(0xffE37373),
                            leading: const Icon(Icons.logout, color: Colors.white,),
                            title: const Text('ออกจากระบบ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white
                              ),
                            ),
                            onTap: (){
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Container(
                                        width: double.infinity,
                                        color: const Color(0xFF4FCC80),
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
                                        const Text(
                                          'ต้องการออกจากระบบหรือไม่',
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
                                                    auth.signOut().then((value){
                                                      Navigator.pushAndRemoveUntil(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context){
                                                                return LoginUI();
                                                              }
                                                          ),
                                                              (route) => false);
                                                    });
                                                  },
                                                  style: ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.green,
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
                                                    backgroundColor: Colors.red,
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
                            },
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
        )
    );
  }
}
