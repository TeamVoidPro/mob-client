import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mob_client/pages/Services.dart';
import 'package:mob_client/pages/Settings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_client/components/AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/AppBar.dart';
import '../components/HalfCircleClipperTopLeft.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool _isCollapsed = false;
  Completer<GoogleMapController> mapController = Completer();
  double _centerLatitude = 6.899138;
  double _centerLongitude = 79.860729;
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(6.899138, 79.860729),
    zoom: 14.4746,
  );

  final List<Marker> _markers = <Marker>[
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(6.8997, 79.8604),
        infoWindow: InfoWindow(
          title: 'My Position',
        )),
  ];

  List<Map<String, dynamic>> _carParks = [
    {
      'name': 'Liberty Plaza Car Park',
      'address': 'Liberty Plaza, Colombo 00300',
      'distance': '1.2km',
      'available': '15',
      'total': '30',
      'lat': 6.916533,
      'lng': 79.860431,
    },
    {
      'name': 'Majestic City Car Park',
      'address': 'Majestic City, Bambalapitiya, Colombo',
      'distance': '2.0km',
      'available': '8',
      'total': '15',
      'lat': 6.891632,
      'lng': 79.854845,
    },
    {
      'name': 'Galle Face Green Car Park',
      'address': 'Galle Face, Colombo 00300',
      'distance': '1.5km',
      'available': '20',
      'total': '25',
      'lat': 6.927193,
      'lng': 79.846602,
    },
    {
      'name': 'Independence Square Car Park',
      'address': 'Independence Square, Colombo 00700',
      'distance': '2.8km',
      'available': '12',
      'total': '18',
      'lat': 6.911217,
      'lng': 79.877742,
    },
    {
      'name': 'Crescat Boulevard Car Park',
      'address': 'Crescat Boulevard, Colombo',
      'distance': '0.8km',
      'available': '5',
      'total': '10',
      'lat': 6.926888,
      'lng': 79.845111,
    },
    {
      'name': 'Nelum Pokuna Car Park',
      'address': 'Nelum Pokuna Mawatha, Colombo 00700',
      'distance': '1.0km',
      'available': '18',
      'total': '25',
      'lat': 6.914904,
      'lng': 79.877088,
    },
    {
      'name': 'Racecourse Car Park',
      'address': 'Reid Avenue, Colombo 00700',
      'distance': '0.4km',
      'available': '7',
      'total': '12',
      'lat': 6.898458,
      'lng': 79.864799,
    },
    {
      'name': 'Dutch Hospital Car Park',
      'address': 'Hospital Street, Colombo 00100',
      'distance': '2.3km',
      'available': '9',
      'total': '15',
      'lat': 6.932320,
      'lng': 79.844012,
    },
    {
      'name': 'Mount Lavinia Beach Parking',
      'address': 'Mount Lavinia, Colombo 10370',
      'distance': '10.5km',
      'available': '22',
      'total': '30',
      'lat': 6.833785,
      'lng': 79.855270,
    },
    {
      'name': 'Viharamahadevi Park Car Park',
      'address': 'Viharamahadevi Park, Colombo 00700',
      'distance': '1.8km',
      'available': '14',
      'total': '20',
      'lat': 6.918818,
      'lng': 79.864850,
    },
    {
      'name': 'Wellawatte Beach Parking',
      'address': 'Wellawatte, Colombo 00600',
      'distance': '5.0km',
      'available': '10',
      'total': '18',
      'lat': 6.874105,
      'lng': 79.857752,
    },
    {
      'name': 'Pettah Market Car Park',
      'address': 'Main Street, Colombo 01100',
      'distance': '2.0km',
      'available': '5',
      'total': '10',
      'lat': 6.937283,
      'lng': 79.850404,
    },
    {
      'name': 'One Galle Face Car Park',
      'address': 'One Galle Face Mall, Galle Road, Colombo',
      'distance': '2.5km',
      'available': '20',
      'total': '28',
      'lat': 6.924123,
      'lng': 79.848760,
    },
    {
      'name': 'Marino Mall Car Park',
      'address': 'Galle Road, Colombo 00300',
      'distance': '3.2km',
      'available': '12',
      'total': '20',
      'lat': 6.924959,
      'lng': 79.854116,
    },
    {
      'name': 'Cinnamon Gardens Car Park',
      'address': 'Cinnamon Gardens, Colombo 00700',
      'distance': '1.5km',
      'available': '8',
      'total': '15',
      'lat': 6.914447,
      'lng': 79.864066,
    },
    // Add more places as needed
  ];

  void getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR" + error.toString());
    });
    var location = await Geolocator.getCurrentPosition();
    CameraPosition cameraPosition = new CameraPosition(
      target: LatLng(location.latitude, location.longitude),
      zoom: 16,
    );
    setState(() {
      _centerLatitude = location.latitude;
      _centerLongitude = location.longitude;
    });

    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    // draw circle around current location
  }

  // Modal for set to preferred location diameter and rate
  void _showSetPreferredLocationModal() {
    showModalBottomSheet<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          // input text field for diameter
          TextEditingController diameterController = TextEditingController();
          // input text field for rate
          TextEditingController rateController = TextEditingController();
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 400,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Set Preferred Location",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Set your preferred location to find the best parking spots for you.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Diameter",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: diameterController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Diameter",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 120, 119, 115),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Rate",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextFormField(
                            controller: rateController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Rate",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 120, 119, 115),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 37, 54, 101),
                              ),
                            ),
                            child: Text(
                              "Set",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  // Modal for set to arrival time and departure time
  void _showSetPreferredTimeModal() {
    showModalBottomSheet<void>(
        barrierColor: Colors.black.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50),
            topRight: Radius.circular(50),
          ),
        ),
        useSafeArea: true,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          // input text field for arrival time
          TextEditingController arrivalTimeController =
              TextEditingController();
          // input text field for departure time
          TextEditingController departureTimeController =
              TextEditingController();
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height: 400,
                  color: Colors.white,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Set Preferred Time",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Set your preferred time to find the best parking spots for you.",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Arrival Time",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: FormBuilderDateTimePicker(
                            name: 'Arrival Time',
                            inputType: InputType.both,
                            decoration: InputDecoration(
                              hintText: "Arrival Time",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 120, 119, 115),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              print(value);
                            },
                          )
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "Departure Time",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child:
                          FormBuilderDateTimePicker(
                            name: 'Departure Time',
                            inputType: InputType.both,
                            decoration: InputDecoration(
                              hintText: "Departure Time",
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 120, 119, 115),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (value) {
                              print(value);
                            },
                          )
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 37, 54, 101),
                              ),
                            ),
                            child: Text(
                              "Set",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    markParkingLocations();
  }

  Future<void> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
  }

  void markParkingLocations() {
    for (int i = 0; i < _carParks.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(_carParks[i]['name']),
          position: LatLng(_carParks[i]['lat'], _carParks[i]['lng']),
          infoWindow: InfoWindow(
            title: _carParks[i]['name'],
            snippet: _carParks[i]['address'],
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet,
          ),
        ),
      );
    }
  }

  void _showBottomDrawer() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return _buildBottomDrawer();
      },
    );
  }

  Widget _buildBottomDrawer() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5, // Initial size of the sheet
      minChildSize: 0.25, // Minimum size of the sheet
      maxChildSize: 0.9, // Maximum size of the sheet
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.grey[200],
          child: ListView.builder(
            controller: scrollController,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('Item $index'),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: appBarComponent(context),
        drawer: drawerComponent(context),
        resizeToAvoidBottomInset: false,
        // Add the rest of your content below
        body: SafeArea(
          child: Stack(
            children: [
              SafeArea(
                child: Column(
                children: [
                  Container(
                    width: screenWidth,
                    height: screenHeight * 0.54,
                    margin: EdgeInsets.only(top: 0),
                    child: GoogleMap(
                      initialCameraPosition: _kGoogle,
                      markers: Set<Marker>.of(_markers),
                      myLocationEnabled: true,
                      mapType: MapType.normal,
                      mapToolbarEnabled: true,
                      compassEnabled: true,
                      myLocationButtonEnabled: false,
                      onMapCreated: (GoogleMapController controller) {
                        mapController.complete(controller);
                      },
                      circles: Set.from([
                        Circle(
                          circleId: CircleId('1'),
                          center: LatLng(6.8997, 79.8604),
                          radius: 800,
                          fillColor: Colors.blue.withOpacity(0.2),
                          strokeColor: Colors.blue,
                          strokeWidth: 1,
                        )
                      ]),
                      trafficEnabled: true,
                      fortyFiveDegreeImageryEnabled: true,
                    ),
                  ),
                  SingleChildScrollView(
                    child: AnimatedContainer(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        width: MediaQuery.of(context).size.width,
                        duration: Duration(milliseconds: 300),
                        height: 300,
                        // Update height based on collapse state
                        child:
                        Padding(
                          padding: EdgeInsets.only(top: 10,bottom: 10),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(left: 16, right: 16),
                                  child:
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Parking Spots Around You",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Today 10:00 AM - 12:30 PM (2.30 hrs)",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            _showSetPreferredTimeModal();
                                          },
                                          style: ButtonStyle(
                                            backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Color.fromARGB(
                                                    255, 37, 54, 101)),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                side: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 37, 54, 101)),
                                              ),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.calendar_month,
                                            color: Colors.white,
                                          ))
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                //Horizontally scrollable list
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: _carParks.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (BuildContext context, int index) {
                                      Map<String, dynamic> carPark =
                                      _carParks[index];
                                      return
                                        Container(
                                          height: 150,
                                          width: 300,
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 8, left: 8),
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
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  carPark['name'],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_outlined,
                                                      size: 20,
                                                      color: Color.fromARGB(
                                                          255, 37, 54, 101),
                                                    ),
                                                    Text(
                                                      carPark['address'],
                                                      softWrap: true,
                                                      textWidthBasis:
                                                      TextWidthBasis.longestLine,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                // Rating Stars
                                                RatingBar.builder(
                                                  tapOnlyMode: true,
                                                  initialRating: 3,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: false,
                                                  itemCount: 5,
                                                  itemSize: 25,
                                                  ignoreGestures: true,
                                                  itemPadding: EdgeInsets.symmetric(
                                                      horizontal: 0.5),
                                                  itemBuilder: (context, _) => Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    print(rating);
                                                  },
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.directions_car_outlined,
                                                      color: Color.fromARGB(
                                                          255, 37, 54, 101),
                                                    ),
                                                    Text(
                                                      " ${carPark['distance']}",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.normal,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "LKR ${carPark['available']} / hr",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 2),
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context, '/book');
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                        MaterialStateProperty.all<
                                                            Color>(
                                                          Color.fromARGB(
                                                              255, 37, 54, 101),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        "Book Now",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                    },
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                ],
              ),
              ),
              Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(top: 5,left: 5,right: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Search Bar
                        Container(
                          width: MediaQuery.of(context).size.width * 0.95,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              //Filter Button
                              Container(
                                margin: EdgeInsets.only(left: 0),
                                child: IconButton(
                                  onPressed: () {
                                    _showSetPreferredLocationModal();
                                  },
                                  icon: Icon(
                                    Icons.filter_alt_outlined,
                                    color: Color.fromARGB(255, 120, 119, 115),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ));
  }
}
