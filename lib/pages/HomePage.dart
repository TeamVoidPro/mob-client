import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_client/pages/Services.dart';
import 'package:mob_client/pages/Settings.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../components/HalfCircleClipperTopLeft.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool _isCollapsed = false;
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );



  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) => IconButton(
              icon: new Icon(Icons.menu,color: Color.fromARGB(255, 5, 30, 101),),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          title: Image.asset(
            "assets/Images/welcome.png",
            fit: BoxFit.contain,
            height: 40,
          ),
          actions: [
            IconButton(
              icon: new Icon(Icons.notifications,color: Color.fromARGB(255, 5, 30, 101),),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ]),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/Images/user.jpeg'),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Mr.Danodya Supun',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'danodya@yahoo.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/premium');
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 5, 30, 101)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(
                            color: Color.fromARGB(255, 37, 54, 101)),
                      ),
                    ),
                  ),
                  child: Text(
                    "Upgrade to Premium",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.miscellaneous_services_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('Services'),
              subtitle: Text('View Services we provide',
              style: TextStyle(
                fontSize: 12,
              ),),
              onTap: () {
                // Handle onTap action for item 1
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Services()));
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.book_online_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('My Booking'),
              subtitle: Text('View previous parkings',
                style: TextStyle(
                  fontSize: 12,
                ),),
              onTap: () {
                // Handle onTap action for item 2
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.local_offer_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('Promotions'),
              subtitle: Text('View promotions',
                style: TextStyle(
                  fontSize: 12,
                ),),
              onTap: () {
                // Handle onTap action for item 3
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.report_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('Complaints'),
              subtitle: Text('View complaints',
                style: TextStyle(
                  fontSize: 12,
                ),),
              onTap: () {
                // Handle onTap action for item 3
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.wallet_giftcard_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('Ease Wallet'),
              subtitle: Text('View Ease Wallet',
                style: TextStyle(
                  fontSize: 12,
                ),),
              onTap: () {
                // Handle onTap action for item 3
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.settings_sharp,color: Color.fromARGB(255, 5, 30, 101),),
              title: Text('Settings'),
              subtitle: Text('View Settings',
                style: TextStyle(
                  fontSize: 12,
                ),),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
                // Handle onTap action for item 3
              },
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            // Add more ListTiles for other items in the drawer
          ],
        ),
      ),
      // Add the rest of your content below

        body:
        Stack(
      children: [
        Container(
          width: screenWidth,
          height: screenHeight,
            margin: EdgeInsets.only(top: 10),
            child: SingleChildScrollView(
              child: Image.asset(
                "assets/Images/mapImage.png",
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Search Bar
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: 350,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.search,
                            color: Color.fromARGB(255, 120, 119, 115),
                          ),
                        ),
                        Container(
                          width: 200,
                          margin: EdgeInsets.only(left: 20),
                          child: TextField(
                            onChanged: (value) {
                              //Do something with the user input.
                              print(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 120, 119, 115),
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            child: AnimatedContainer(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),
              width: MediaQuery.of(context).size.width,
              duration: Duration(milliseconds: 300),
              height: _isCollapsed
                  ? 100
                  : 350, // Update height based on collapse state
              child:
                  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isCollapsed = !_isCollapsed; // Toggle the collapse state
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 120, 119, 115),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                if (!_isCollapsed)
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Booking For",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.normal),
                        ),
                        IconButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 37, 54, 101)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 37, 54, 101)),
                                ),
                              ),
                            ),
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                if (!_isCollapsed)
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Today 10:00 AM - 12:30 PM (2.30 hrs)",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                if (!_isCollapsed) SizedBox(height: 8),
                //Horizonatally scrollable list
                if (!_isCollapsed)
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(left: 16, right: 16),
                      children: [
                        for (int i=0;i<10;i++)
                          Container(
                              height: 200,
                              width: 300,
                              margin: EdgeInsets.only(right: 16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              padding: EdgeInsets.all(8),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "University of Colombo - Car Park",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Text(
                                          "Colombo 03",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    // Rating Stars
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Icon(
                                          Icons.star,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                      ],
                                    ),

                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.directions_car_outlined,
                                          color: Color.fromARGB(255, 37, 54, 101),
                                        ),
                                        Text(
                                          " 8 min ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        Text(
                                          "  0.5 km",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "LKR 200 / hr",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 2),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, '/book');
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 37, 54, 101)),
                                          ),
                                          child: Text(
                                            "Book Now",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                      ],
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ],
    ));
  }
}
