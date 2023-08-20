import 'package:flutter/material.dart';
import 'package:mob_client/models/Driver.dart';
import 'package:mob_client/providers/userProvider.dart';
import 'package:provider/provider.dart';

import '../pages/ReservationPage.dart';
import '../pages/Services.dart';
import '../pages/Settings.dart';

PreferredSizeWidget appBarComponent(BuildContext context) {
  return AppBar(
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: const Color.fromARGB(136, 84, 143, 218),
          height: 1.5,
        ),
      ),
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/Images/welcome.png",
            fit: BoxFit.contain,
            height: 40,
            alignment: Alignment.center,
          )
        ],
      ),
      actions: [
        IconButton(
          icon: new Icon(
            Icons.notifications,
            color: const Color.fromARGB(255, 5, 30, 101),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: new Icon(
                Icons.local_parking_sharp,
                // Green Color
                color: const Color.fromARGB(255, 5, 30, 101),
              ),
              onPressed: () => {
                _showOngoingParking(context),
              },
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: const BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: const SizedBox(
                  height: 10,
                  width: 10,
                ),
              ),
            )
          ],
        ),
      ]);
}

Widget drawerComponent(BuildContext context) {
  final _userProvider = Provider.of<userProvider>(context);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              opacity: 0.5,
              image: AssetImage("assets/Images/sidebarImage.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage:
                    NetworkImage(_userProvider.user!.profilePicture),
                // AssetImage('assets/Images/user.jpeg'),
              ),
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _userProvider.user!.fullName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        _userProvider.user!.email,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 10),
                  // Sign Out Button
                  Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 5, 30, 101),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _userProvider.clearAll();
                        Navigator.pushNamed(context, '/login');
                      },
                    ),
                  ),
                ],
              )
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
                    const Color.fromARGB(255, 5, 30, 101)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: const BorderSide(
                        color: Color.fromARGB(255, 37, 54, 101)),
                  ),
                ),
              ),
              child: const Text(
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
          leading: const Icon(
            Icons.book_online_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('My Booking'),
          subtitle: const Text(
            'View previous parkings',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReservationPage()));
            // Handle onTap action for item 2
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.local_offer_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('My Payments'),
          subtitle: const Text(
            'View Payments',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            // Handle onTap action for item 3
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.report_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('My Vehicles'),
          subtitle: const Text(
            'View Registered Vehicles',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationPage()));
            // Handle onTap action for item 3
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.miscellaneous_services_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('Services'),
          subtitle: const Text(
            'View Services we provide',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            // Handle onTap action for item 1
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Services()));
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.help_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('Help & Support'),
          subtitle: const Text(
            'View Help & Support',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            // Handle onTap action for item 3
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        ListTile(
          leading: const Icon(
            Icons.settings_sharp,
            color: Color.fromARGB(255, 5, 30, 101),
          ),
          title: const Text('Settings'),
          subtitle: const Text(
            'View Settings',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Settings()));
            // Handle onTap action for item 3
          },
        ),
        const Divider(
          height: 1,
          thickness: 1,
        ),
        // Add more ListTiles for other items in the drawer
      ],
    ),
  );
}

//showOngoingParking bottom sheet modal
// show the list of ongoing parking for the user
void _showOngoingParking(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return DraggableScrollableSheet(
          initialChildSize: 1, // Initial size of the sheet
          minChildSize: 1, // Minimum size of the sheet
          maxChildSize: 1, // Maximum size of the sheet
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 10, top: 8, bottom: 8),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 34, 43, 69),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ongoing Parking',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                ),
                // Add shadow line to seperate the header and the list
                Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 1.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(1.0, 1.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Container(
                  color: Colors.grey[200],
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          margin: const EdgeInsets.only(
                              top: 20, left: 10, right: 10),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 34, 43, 69),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            child: const Image(
                                              image: AssetImage(
                                                  'assets/Images/ucsc.png'),
                                              width: 40,
                                              height: 40,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          const Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'UCSC Car Park ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                ' Colombo 07',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Time : ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                '10.00 AM - 12.00 PM',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Reference ID : ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                'RFC - ABC3245',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Price : ',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14
                                                ),
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                'LKR 400.00',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: const Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '23',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 43, 69),
                                          fontSize: 48,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'JUNE',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 43, 69),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '2023',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 34, 43, 69),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ))
              ],
            );
          },
        );
      });
}
