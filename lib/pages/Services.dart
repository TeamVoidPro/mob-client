import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Services extends StatelessWidget {

  List<Widget> imageList = [
    Image.asset('assets/Images/services.jpg'),
    Image.asset('assets/Images/services2.jpg'),
    Image.asset('assets/Images/services3.jpg'),
    Image.asset('assets/Images/services.jpg'),
    Image.asset('assets/Images/services2.jpg'),
  ];


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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 2.0, // Adjust as needed
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                  autoPlay: true,
                ),
                items: imageList,
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
            ]
        ),
      ),
      );
  }
}