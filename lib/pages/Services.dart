import 'package:flutter/material.dart';

class Services extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: .0,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Services',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
      ),
      ),
      body: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/Images/services.jpg'), // Replace with your image asset

      // Text Overlay
                  Positioned(
                    top: 100, // Adjust the top position as needed
                    left: 50, // Adjust the left position as needed
                    child: Text(
                      'Get ready to revolutionize your parking routine with our services',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ],
              ),
              Container(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.blue[100],
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.local_parking_sharp,
                                    size: 48,
                                    color: Colors.blue[900],
                                  ),
                                  Text(
                                    'Quick Parking Reservation',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                        ),
                        SizedBox(width: 30,),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.navigation_outlined,
                                size: 48,
                                color: Colors.blue[900],
                              ),
                              Text(
                                'In App Navigation',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.black, fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_active_sharp,
                                size: 48,
                                color: Colors.blue[900],
                              ),
                              Text(
                                'Real Time Notifications',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 30,),
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.design_services_sharp,
                                size: 48,
                                color: Colors.blue[900],
                              ),
                              Text(
                                '24/7 Customer Support',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                              ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ]
                ),
              ),
              Container(
                height: 79.30,
                width: 500,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 54, 101),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
              ),
            ]
          ),
      );
  }
}