import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:mob_client/pages/BookingPage.dart';
import 'package:mob_client/pages/Services.dart';
import 'package:mob_client/pages/Settings.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mob_client/components/AppBar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/AppBar.dart';
import '../components/HalfCircleClipperTopLeft.dart';
import '../data/PlacesAutoCompleteResponse.dart';
import '../data/Prediction.dart';
import '../utils/Request.dart';

class FindPark extends StatefulWidget {
  final Response? parks;

  const FindPark({Key? key, required this.parks}) : super(key: key);

  @override
  State<FindPark> createState() => _MyFindParkState();
}

class _MyFindParkState extends State<FindPark> {
  bool _isCollapsed = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Completer<GoogleMapController> mapController = Completer();
  Set<Marker> _markers = Set();
  late BitmapDescriptor carIcon;
  double _centerLatitude = 6.899138;
  double _centerLongitude = 79.860729;
  List<Map<String, dynamic>> _carParks = [];
  late String arrivalTime;
  late String departureTime;

  // input text field for arrival time
  TextEditingController arrivalTimeController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  TextEditingController diameterController = TextEditingController(text: "5");
  List<Prediction> _predictions = [];

  // input text field for departure time
  TextEditingController departureTimeController = TextEditingController();
  double bottomSheetHeight = 0.8;
  List<Circle> circles = [
    Circle(
      circleId: CircleId('1'),
      center: LatLng(6.8997, 79.8604),
      radius: 1000,
      fillColor: Colors.blue.withOpacity(0.2),
      strokeColor: Colors.blue,
      strokeWidth: 1,
    )
  ];
  static final CameraPosition _kGoogle = const CameraPosition(
    target: LatLng(6.899138, 79.860729),
    zoom: 14.4746,
  );

  void FindParkByTime() async {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black.withOpacity(0.5),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        });

    DateTime arrivalTime = DateTime.parse(arrivalTimeController.text);
    DateTime departureTime = DateTime.parse(departureTimeController.text);

    Object? data = {
      'DriverLatitude': _centerLatitude.toString(),
      'DriverLongitude': _centerLongitude.toString(),
      'ArrivalTime': arrivalTime.toIso8601String(),
      'DepartureTime': departureTime.toIso8601String(),
      'Radius': double.parse(diameterController.text),
    };
    //validate ArrivalTime and DepartureTime
    if (arrivalTimeController.text.isEmpty ||
        departureTimeController.text.isEmpty) {
      // show banner
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all the fields'),
          duration: const Duration(seconds: 2),
          elevation: 100,
          behavior: SnackBarBehavior.floating,
          dismissDirection: DismissDirection.up,
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      Navigator.pop(context);
      return;
    }

    // check arrivalTime < departureTime
    if (arrivalTimeController.text.compareTo(departureTimeController.text) >
        0) {
      // show banner
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Arrival Time should be less than Departure Time'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      Navigator.pop(context);
      return;
    }

    BitmapDescriptor carIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        // size: Size(2, 2),
        platform: TargetPlatform.android,
      ), // Set the size you want
      'assets/Icons/park.png', // Path to your car icon image in the assets folder
    );
    print(data);
    var res = await sendAuthPOSTRequest("/get-nearest-park", data);
    Map<String, dynamic> response = jsonDecode(res.toString());
    var carParks = response['parkingPlaces'];

    Set<Marker> _markersToShow = Set();
    print(carParks.length);

    for (int i = 0; i < carParks.length; i++) {
      _carParks.add(carParks[i]);

      _markersToShow.add(
        Marker(
          markerId: MarkerId(carParks[i]['name']),
          position: LatLng(carParks[i]['latitude'], carParks[i]['longitude']),
          infoWindow: InfoWindow(
            title: carParks[i]['name'],
            snippet: carParks[i]['address'],
          ),
          icon: carIcon,
          flat: true,
        ),
      );
    }

    setState(() {
      _markers.clear();
      _markers = _markersToShow.toSet();
      mapController.future.then((value) => {
            value.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    _centerLatitude,
                    _centerLongitude,
                  ),
                  zoom: 16,
                ),
              ),
            ),
          });
    });

    // close bottom sheet
    Navigator.pop(context);
  }

  void FilterPark() {
    Object? data = {
      'DriverLatitude': _centerLatitude,
      'DriverLongitude': _centerLongitude,
      'ArrivalTime': arrivalTimeController.text,
      'DepartureTime': departureTimeController.text,
      'Radius': 800,
    };
    //validate ArrivalTime and DepartureTime
    if (arrivalTimeController.text.isEmpty ||
        departureTimeController.text.isEmpty) {
      // show banner
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all the fields'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return;
    }

    // check arrivalTime < departureTime
    if (arrivalTimeController.text.compareTo(departureTimeController.text) >
        0) {
      // show banner
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              const Text('Arrival Time should be less than Departure Time'),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Code to execute.
            },
          ),
        ),
      );
      return;
    }

    sendAuthPOSTRequest("/get-nearest-park", data).then((value) => {
          print(value),
          // Navigator.pushNamed(context, '/book'),
        });
    // Navigator.push(context, MaterialPageRoute(builder: (context) => FindPark()));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserCurrentLocation();
    _loadCarIcon();

    Map<String, dynamic> response = jsonDecode(widget.parks.toString());
    var resArrivalTime = response['arrivalTime'];
    var resDepartureTime = response['departureTime'];

    setState(() {
      var carParks = response['parkingPlaces'];
      arrivalTime =
          DateFormat('hh:mm a').format(DateTime.parse(resArrivalTime));
      departureTime =
          DateFormat('hh:mm a').format(DateTime.parse(resDepartureTime));

      Set<Marker> _markersToShow = Set();
      print(_carParks);

      for (int i = 0; i < carParks.length; i++) {
        _carParks.add(carParks[i]);
        _markersToShow.add(
          Marker(
            markerId: MarkerId(carParks[i]['name']),
            position: LatLng(carParks[i]['latitude'], carParks[i]['longitude']),
            infoWindow: InfoWindow(
              title: carParks[i]['name'],
              snippet: carParks[i]['address'],
            ),
            flat: true,
          ),
        );
      }

      setState(() {
        _markers = _markersToShow.toSet();
      });
    });
  }

  Future<void> _loadCarIcon() async {
    final BitmapDescriptor data = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        // size: Size(2, 2),
        platform: TargetPlatform.android,
      ), // Set the size you want
      'assets/Icons/park.png', // Path to your car icon image in the assets folder
    );

    setState(() {
      carIcon = data;
    });
  }

  Future<void> getParks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
    Object? data = {
      'DriverLatitude': _centerLatitude,
      'DriverLongitude': _centerLongitude,
      'ArrivalTime': arrivalTimeController.text,
      'DepartureTime': departureTimeController.text,
      'Radius': 800,
    };
    BitmapDescriptor carIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        // size: Size(2, 2),
        platform: TargetPlatform.android,
      ), // Set the size you want
      'assets/Icons/park.png', // Path to your car icon image in the assets folder
    );
    var res = await sendAuthPOSTRequest("/get-nearest-park", data);
    Map<String, dynamic> response = jsonDecode(res.toString());
    setState(() {
      var carParks = response['parkingPlaces'];

      Set<Marker> _markersToShow = Set();

      for (int i = 0; i < carParks.length; i++) {
        _carParks.add(carParks[i]);

        _markersToShow.add(
          Marker(
            markerId: MarkerId(carParks[i]['name']),
            position: LatLng(carParks[i]['lat'], carParks[i]['lng']),
            infoWindow: InfoWindow(
              title: carParks[i]['name'],
              snippet: carParks[i]['address'],
            ),
            icon: carIcon,
            flat: true,
          ),
        );
      }

      setState(() {
        _markers = _markersToShow.toSet();
      });
    });
  }

  Future<void> PlacesAutoComplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "/maps/api/place/autocomplete/json",
      {
        "key": "AIzaSyDFl537nYb0R7zQNcXk9Xrmniy00aM7sK4",
        "input": query,
        "components": "country:lk",
      },
    );
    Dio _dio = new Dio();
    var response = await _dio.get(uri.toString());
    PlacesAutoCompleteResponse placesAutoCompleteResponse =
        PlacesAutoCompleteResponse.fromJson(response.data);
    List<Prediction> predictions = placesAutoCompleteResponse.predictions;
    setState(() {
      // print(predictions.length);
      _predictions = predictions;
    });
  }

  void getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
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

  void selectPlace(String placeId) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "/maps/api/place/details/json",
      {
        "key": "AIzaSyDFl537nYb0R7zQNcXk9Xrmniy00aM7sK4",
        "place_id": placeId,
      },
    );
    Dio _dio = new Dio();
    var response = await _dio.get(uri.toString());
    print(response.data);
    Map<String, dynamic> placeDetails = response.data['result'];
    CameraPosition cameraPosition = new CameraPosition(
      target: LatLng(
        placeDetails['geometry']['location']['lat'],
        placeDetails['geometry']['location']['lng'],
      ),
      zoom: 18,
    );
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    //add radius circle
    //add markers

    setState(() {
      _predictions = [];
      circles = [
        Circle(
          circleId: CircleId('1'),
          center: LatLng(
            placeDetails['geometry']['location']['lat'],
            placeDetails['geometry']['location']['lng'],
          ),
          radius: 800,
          fillColor: Colors.blue.withOpacity(0.2),
          strokeColor: Colors.blue,
          strokeWidth: 1,
        )
      ];
    });
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
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  height:
                      MediaQuery.of(context).size.height * bottomSheetHeight,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
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
                              "Arrival Date & Time",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: FormBuilderDateTimePicker(
                                name: 'Arrival Date & Time',
                                format: DateFormat("y MMM d HH:mm"),
                                inputType: InputType.both,
                                decoration: InputDecoration(
                                  hintText: "Arrival Time",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 120, 119, 115),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                initialDate: DateTime.now(),
                                onChanged: (value) {
                                  arrivalTimeController.text = value.toString();
                                },
                                validator: (value) {
                                  if (value == null) {
                                    setState(() {
                                      bottomSheetHeight = 0.75;
                                    });
                                    return 'Please select Arrival Date & Time';
                                  }
                                  return null;
                                },
                              )),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Departure Date & Time",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10),
                              child: FormBuilderDateTimePicker(
                                name: 'Departure Date & Time',
                                inputType: InputType.both,
                                initialDate: DateTime.now(),
                                validator: (value) {
                                  if (value == null) {
                                    setState(() {
                                      bottomSheetHeight = 0.75;
                                    });
                                    return 'Please select Departure Date & Time';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: "Departure Time",
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 120, 119, 115),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  suffixIcon: Icon(Icons.calendar_today),
                                ),
                                onChanged: (value) {
                                  departureTimeController.text =
                                      value.toString();
                                },
                              )),
                          // Select Vehicle
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Select Vehicle",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child:
                                //Select Vehicle
                                DropdownButtonFormField(
                              decoration: InputDecoration(
                                hintText: "Select Vehicle",
                                hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 120, 119, 115),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  child: Text("Vehicle 1"),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text("Vehicle 2"),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text("Vehicle 3"),
                                  value: 3,
                                ),
                              ],
                              onChanged: (value) {
                                print(value);
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              "Radius (Km)",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: TextFormField(
                              controller: diameterController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Radius (Km)",
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
                            margin: const EdgeInsets.only(top: 10),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  FindParkByTime();
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                  Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              child: Text(
                                "Find Parking",
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
                  ),
                );
              },
            ),
          );
        });
  }

  Future<void> getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('userToken');
  }

  void markParkingLocations() {}

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

    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
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
                          height: screenHeight * 0.5,
                          margin: EdgeInsets.only(top: 0),
                          child: GoogleMap(
                            initialCameraPosition: _kGoogle,
                            markers: _markers,
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
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Parking Spots Around You",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "${arrivalTime} - ${departureTime}",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _showSetPreferredTimeModal();
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                              Color>(
                                                          Color.fromARGB(255,
                                                              37, 54, 101)),
                                                  shape:
                                                      MaterialStateProperty.all<
                                                          RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      side: BorderSide(
                                                          color: Color.fromARGB(
                                                              255,
                                                              37,
                                                              54,
                                                              101)),
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
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            Map<String, dynamic> carPark =
                                                _carParks[index];
                                            return Container(
                                              height: 150,
                                              width: 300,
                                              alignment: Alignment.center,
                                              margin: EdgeInsets.only(
                                                  right: 8, left: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                  color: Color.fromARGB(
                                                      255, 37, 54, 101),
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    SizedBox(height: 2),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_on_outlined,
                                                          size: 20,
                                                          color: Color.fromARGB(
                                                              255, 37, 54, 101),
                                                        ),
                                                        Text(
                                                          " ${double.parse(carPark['distance'].toString()).toStringAsFixed(1)} km",
                                                          softWrap: true,
                                                          textWidthBasis:
                                                              TextWidthBasis
                                                                  .longestLine,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
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
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: false,
                                                      itemCount: 5,
                                                      itemSize: 25,
                                                      ignoreGestures: true,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0.5),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        print(rating);
                                                      },
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .directions_car_outlined,
                                                          color: Color.fromARGB(
                                                              255, 37, 54, 101),
                                                        ),
                                                        Text(
                                                          " ${carPark['Distance']}",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 2),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "LKR ${carPark['available']} / hr",
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 2),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => BookingPage(
                                                                        carPark:
                                                                            carPark,
                                                                        parks: widget
                                                                            .parks)));
                                                          },
                                                          style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all<Color>(
                                                              Color.fromARGB(
                                                                  255,
                                                                  37,
                                                                  54,
                                                                  101),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Book Now",
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
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
                              )),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Icon(
                                      Icons.search,
                                      color: Color.fromARGB(255, 120, 119, 115),
                                    ),
                                  ),
                                  Container(
                                    width: 250,
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextField(
                                      onChanged: (value) {
                                        //Do something with the user input.
                                        PlacesAutoComplete(value);
                                      },
                                      controller: searchController,
                                      decoration: InputDecoration(
                                        hintText: "Search",
                                        suffixIcon: searchController.text != ""
                                            ? IconButton(
                                                onPressed: () {
                                                  searchController.clear();
                                                  setState(() {
                                                    _predictions = [];
                                                  });
                                                  getUserCurrentLocation();
                                                },
                                                icon: Icon(
                                                  Icons.clear,
                                                  color: Color.fromARGB(
                                                      255, 120, 119, 115),
                                                ),
                                              )
                                            : null,
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 120, 119, 115),
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
                                        color:
                                            Color.fromARGB(255, 120, 119, 115),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (_predictions.length > 0)
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  primary: false,
                                  itemCount: _predictions.length,
                                  itemBuilder: (context, index) => ColoredBox(
                                    color: Colors.white.withOpacity(0.8),
                                    child: ListTile(
                                      onTap: () {
                                        searchController.text =
                                            _predictions[index].description;
                                        selectPlace(
                                            _predictions[index].placeId);
                                        setState(() {
                                          _predictions = [];
                                        });
                                      },
                                      title: Text(
                                        _predictions[index].description,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                          ],
                        ),
                      )),
                ],
              ),
            )));
  }
}
