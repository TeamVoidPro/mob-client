import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          // Set Appbar background color to transparent
          elevation: .0,
          leading: IconButton(
            icon: Icon(Icons.menu, color: Colors.black,),
            // Set icon color to black
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Settings',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                height: 200,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.indigo[900],
                  borderRadius: BorderRadius.circular(20),
                ),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/Images/user.jpeg'),
                      ),
                    ]
                  ),
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Danodya Supun',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6,),
                    Text(
                      'danodya_supun@yahoo.com',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '071 1234567',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                ]
              ),
              )
            ]
    )
    );
  }
}