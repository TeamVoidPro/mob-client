

import 'package:flutter/material.dart';

class ErrorPage extends StatefulWidget {
  final String errorString;
  const ErrorPage({required this.errorString,super.key});

  @override
  State<ErrorPage> createState() => _ErrorPage();
}

class _ErrorPage extends State<ErrorPage> {


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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Center(
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
                size: 150,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                widget.errorString,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 37, 54, 101),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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