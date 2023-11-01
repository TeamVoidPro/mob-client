

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mob_client/pages/BookingPaymentPage.dart';
import 'package:mob_client/pages/HomePage.dart';
import 'package:mob_client/utils/Request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import 'FindPark.dart';

class BookingPage extends StatefulWidget {
  final Map<String, dynamic> carPark;
  final Response? parks;

  const BookingPage({Key? key, required this.carPark, required this.parks})
      : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> {
  late Map<String, dynamic> carPark;
  List<dynamic> zones = [];
  int duration = 1;
  DateTime arrivalTime = DateTime.now();
  DateTime departureTime = DateTime.now();

  // Define Array of cards
  String _selectedICard = "";
  double _selectedPrice = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getZone();
    arrivalTime = DateTime.parse(widget.parks!.data['arrivalTime']);
    departureTime = DateTime.parse(widget.parks!.data['departureTime']);
    var _duration = departureTime.difference(arrivalTime).inHours;
    setState(() {
      carPark = widget.carPark;
      duration = _duration;
    });
  }

  Future<void> getZone() async {
    var url = '/get-zones/${widget.carPark['parkingPlaceId']}';
    var response = await sendAuthGETRequest(url);
    print(response);
    setState(() {
      zones = response!.data['zones'];
    });
    _selectedICard = zones[0]['zoneId'];
    _selectedPrice = zones[0]['zonePrice'];
  }

  void _launchDialer(phone) async {
    // Make url as Uri
    final Uri uri = Uri(
      scheme: 'tel',
      path: phone,
    );
    await launchUrl(uri);
    await FlutterPhoneDirectCaller.callNumber(phone);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Response? resParks = widget.parks;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_left,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FindPark(parks: resParks),
              ),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Image(image: AssetImage('assets/Images/vehiclePark.png')),
            Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Chip(
                                label: Row(children: [
                                  const Icon(Icons.car_rental,
                                      color: Colors.black, size: 20),
                                  SizedBox(width: 5),
                                  Text('Ground Parking',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      )),
                                ]),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                side: const BorderSide(
                                    color: Colors.transparent, width: 1),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    Color.fromARGB(255, 151, 199, 138)),
                            SizedBox(
                              width: 4,
                            ),
                            Chip(
                                label: Row(children: [
                                  const Icon(Icons.star,
                                      color: Colors.white, size: 20),
                                  SizedBox(width: 5),
                                  Text('4.5 Star',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 12,
                                      )),
                                ]),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                side: const BorderSide(
                                    color: Colors.transparent, width: 1),
                                shadowColor: Colors.transparent,
                                backgroundColor:
                                    Color.fromARGB(255, 250, 201, 131)),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              carPark['name'],
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
                    const SizedBox(width: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_calendar_rounded),
                      color: Colors.white,
                      iconSize: 30,
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 37, 54, 101)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: const BorderSide(
                                          color: Colors.black)))),
                    )
                  ],
                )),
            // Line Separator
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Divider(
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
                      onPressed: () async {
                        await launchUrl(Uri.parse(
                            'google.navigation:q=${carPark['latitude']},${carPark['longitude']}&key=AIzaSyDQ1BEqGpYixqC1UYfnkO-EluckHFwWegE'));
                      },
                      child: const Row(
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
                      onPressed: () async {
                        _launchDialer("0771234567");
                      },
                      child: const Row(
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
                      onPressed: () {
                        Navigator.pushNamed(context, '/chat');
                      },
                      child: const Row(
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
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: const Divider(
                color: Colors.black,
                height: 20,
                thickness: 1,
                indent: 0,
                endIndent: 0,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: width,
                    child: Text(
                        "Welcome to our Downtown Parking Zones, where convenience meets accessibility! Our downtown parking area is designed to cater to the needs of both visitors and locals, providing a secure and easily accessible space for your vehicle.",
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.clip,
                        softWrap: true,
                        style: TextStyle(
                          overflow: TextOverflow.clip,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 14,
                        )),
                  ),
                  SizedBox(height: 10),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Select Zone",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // show zones
                  SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            if (zones.length == 0)
                              Text("No Zones Available")
                            else
                              for (int i = 0; i < zones.length; i++)
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedICard = zones[i]['zoneId'];
                                        _selectedPrice = zones[i]['zonePrice'];
                                      });
                                    },
                                    child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        opacity:
                                            _selectedICard == zones[i]['zoneId']
                                                ? 1.0
                                                : 0.5,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: 150,
                                              height: 80,
                                              padding: const EdgeInsets.all(5),
                                              margin: const EdgeInsets.only(
                                                  right: 10, top: 10),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                  color: const Color.fromARGB(
                                                      255, 37, 54, 101),
                                                  width: 2,
                                                ),
                                              ),
                                              child: Column(
                                                children: <Widget>[
                                                  Text(
                                                    zones[i]['zoneName'],
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  SizedBox(height: 10),
                                                  Text(
                                                    '${zones[i]['zonePrice'] * duration}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            if (_selectedICard ==
                                                zones[i]['zoneId'])
                                              Positioned(
                                                top: 5,
                                                right: 5,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 38, 194, 129),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    border: Border.all(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              38,
                                                              194,
                                                              129),
                                                      width: 2,
                                                    ),
                                                  ),
                                                  child: const Icon(Icons.check,
                                                      color: Colors.black,
                                                      size: 20),
                                                ),
                                              ),
                                          ],
                                        )))
                          ])),
                  const SizedBox(height: 10),
                  // SingleChildScrollView(
                  //   scrollDirection: Axis.horizontal,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       for(int i=0;i<5;i++)
                  //         GestureDetector(
                  //             onTap: (){
                  //               setState(() {
                  //                 _selectedICard = i;
                  //               });
                  //             },
                  //             child: AnimatedOpacity(
                  //                 duration: const Duration(milliseconds: 500),
                  //                 opacity: _selectedICard == i ? 1.0 : 0.5,
                  //                 child:
                  //                 Stack(
                  //                   children: [
                  //                     Container(
                  //                       width: 150,
                  //                       height: 80,
                  //                       padding: const EdgeInsets.all(5),
                  //                       margin: const EdgeInsets.only(right: 10,top: 10),
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.white,
                  //                         borderRadius: BorderRadius.circular(10),
                  //                         border: Border.all(
                  //                           color: const Color.fromARGB(255, 37, 54, 101),
                  //                           width: 2,
                  //                         ),
                  //                       ),
                  //                       child:
                  //                       const Column(
                  //                         children: <Widget>
                  //                         [
                  //                           Text("1 hr - 2 hrs",
                  //                               textAlign: TextAlign.left,
                  //                               style: TextStyle(
                  //                                 fontWeight: FontWeight.bold,
                  //                                 color: Colors.black,
                  //                                 fontSize: 18,
                  //                               )),
                  //                           SizedBox(height: 10),
                  //                           Text("Rs. 100",
                  //                               textAlign: TextAlign.left,
                  //                               style: TextStyle(
                  //                                 fontWeight: FontWeight.bold,
                  //                                 color: Colors.black,
                  //                                 fontSize: 18,
                  //                               ))
                  //                         ],
                  //                       ),
                  //                     ),
                  //                     if(_selectedICard == i)
                  //                       Positioned(
                  //                         top: 5,
                  //                         right: 5,
                  //                         child:
                  //                         Container(
                  //                           padding: const EdgeInsets.all(5),
                  //                           decoration: BoxDecoration(
                  //                             color: const Color.fromARGB(255, 38, 194, 129),
                  //                             borderRadius: BorderRadius.circular(100),
                  //                             border: Border.all(
                  //                               color: const Color.fromARGB(255, 38, 194, 129),
                  //                               width: 2,
                  //                             ),
                  //                           ),
                  //                           child: const Icon(Icons.check, color: Colors.black, size: 20),
                  //                         ),
                  //                       ),
                  //                   ],
                  //                 )
                  //             )
                  //         )
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // Reserve Button
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingPaymentPage(
                              ZoneID : "${_selectedICard}",
                              ParkingPlaceID: "${carPark['parkingPlaceId']}",
                              Duration: "${duration}",
                              TotalAmount: "${(_selectedPrice * duration).round()}.00",
                              ParkingLocation: "Slot 1",
                              ArrivingDate: arrivalTime.toString(),
                              DepartureDate: departureTime.toString(),
                              VehicleDetails: 'KJ-1234',
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 200,
                        height: 50,
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 37, 54, 101),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color.fromARGB(255, 37, 54, 101),
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
                              "${(_selectedPrice * duration).round()}.00",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
