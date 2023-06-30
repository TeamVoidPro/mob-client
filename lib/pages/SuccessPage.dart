

import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({super.key});

  @override
  State<SuccessPage> createState() => _SuccessPage();
}

class _SuccessPage extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pushNamed(context, '/book/payment');
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
          Image(image: AssetImage("assets/Images/qr.png")),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(onPressed: (){},
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
                )
            ),
          )
        ],
      ),
    );
  }
}