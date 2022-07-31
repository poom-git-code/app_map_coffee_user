import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowimageMaxSize extends StatefulWidget {

  String id;
  String? email;
  String url;

  ShowimageMaxSize(this.id,this.email,this.url);

  @override
  State<ShowimageMaxSize> createState() => _ShowimageMaxSizeState();
}

class _ShowimageMaxSizeState extends State<ShowimageMaxSize> {

  @override
  Widget build(BuildContext context) {

    double wi = MediaQuery.of(context).size.width;
    double hi = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            SizedBox(
              width: wi,
              height: hi,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/Coffee_icon.png',
                image: widget.url,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: wi,
              height: hi * 0.11,
              color: Colors.black26,
              child: Padding(
                padding: EdgeInsets.only(left: wi * 0.05, top: hi * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          FontAwesomeIcons.arrowLeftLong,
                          color: Colors.white70,
                          size: 22,
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: wi * 0.26),
                      child: Text(
                        'รูปภาพ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white70
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
