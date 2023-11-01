

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SuccessPage extends StatefulWidget {
  final String? ParkingLocation;
  final String? SlotID;
  const SuccessPage({Key? key, required this.ParkingLocation, required this.SlotID}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPage();
}

class _SuccessPage extends State<SuccessPage> {

  void initState() {
    super.initState();
    Dio dio = new Dio();
    dio.get("https://parkease.azurewebsites.net/api/QrCode/generate-qr-code-image?text=Hello")
        .then((value) => {
          //save the image to the local storage
          ImageGallerySaver.saveImage(value.data)

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            // Navigator.pushNamed(context, '/home');
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Center(
              child: Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 150,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Success!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          QrImageView(
            data: widget.SlotID!,
            version: QrVersions.auto,
            size: 300.0,
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 37, 54, 101),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home),
                    SizedBox(width: 10,),
                    Text("Go Home")
                  ],
                ),

            ),
          )
        ],
      ),
    );
  }
}