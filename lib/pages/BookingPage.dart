import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> {

  // Define Array of cards
  int _selectedICard = -1;

  void _launchDialer() async {
    final phoneNumber = '1234567890';
    final url = 'tel:$phoneNumber';
    // Make url as Uri
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // Handle error when the dialer app cannot be launched.
      print('Could not launch dialer.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.keyboard_arrow_left),
        ],
      )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/Images/vehiclePark.png')),
            Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_rounded,
                              color: Colors.black,
                            ),
                            Text(
                              '  Reserve your parking spot 78/B',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'University of Colombo Car Park',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_calendar_rounded),
                      color: Colors.white,
                      iconSize: 30,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 37, 54, 101)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black)))),
                    )
                  ],
                )),
            // Line Separator
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
            ),
            // Define three buttons Direction , Call , Chat with icon in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.directions_rounded,
                              color: Colors.black, size: 30),
                          SizedBox(width: 5),
                          Text(
                            'Direction',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        // _launchDialer();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.call, color: Colors.black, size: 30),
                          SizedBox(width: 5),
                          Text(
                            'Call',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(Icons.chat, color: Colors.black, size: 30),
                          SizedBox(width: 5),
                          Text(
                            'Chat',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            // Line Separator
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Info",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                      "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                      "when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                      " It has survived not only five centuries,",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Price Tariff",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                      "Lorem Ipsum has been the industry's standard dummy text ever ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      )),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for(int i=0;i<5;i++)
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _selectedICard = i;
                              });
                            },
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: _selectedICard == i ? 1.0 : 0.5,
                              child:
                              Stack(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 80,
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(right: 10),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Color.fromARGB(255, 37, 54, 101),
                                        width: 2,
                                      ),
                                    ),
                                    child:
                                    Column(
                                      children:
                                      [
                                        Text("1 hr - 2 hrs",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18,
                                            )),
                                        SizedBox(height: 10),
                                        Text("Rs. 100",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: 18,
                                            ))
                                      ],
                                    ),
                                  ),
                                  if(_selectedICard == i)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child:
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.only(right: 10),
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 37, 54, 101),
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                            color: Color.fromARGB(255, 37, 54, 101),
                                            width: 2,
                                          ),
                                        ),
                                        child: Icon(Icons.check, color: Colors.white, size: 20),
                                      ),
                                    ),
                                ],
                              )
                            )
                          )
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  // Reserve Button
                  TextButton(
                      onPressed: (){},

                      child:
                      Container(
                        width: 200,
                        height: 50,
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 37, 54, 101),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Color.fromARGB(255, 37, 54, 101),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reserve : LKR',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(width: 5),
                            Text(
                              '100',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
