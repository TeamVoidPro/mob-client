import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePage();
}

class _AddVehiclePage extends State<AddVehiclePage> {
  bool _value = false;

  // Create a DropDown list
  String vehicleTypeValue = 'Car';

  // Create a list of items
  List<String> items = ['Car', 'Bike', 'Truck', 'Bus', 'Van'];
  // Define the icon for the DropDown list items
  Map<String, IconData> icons = {
    'Car': Icons.car_rental,
    'Bike': Icons.motorcycle,
    'Truck': Icons.local_shipping,
    'Bus': Icons.directions_bus,
    'Van': Icons.directions_car_filled,
  };

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 37, 54, 101),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
              child: Text(
                "Skip Now",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/home');
          },
        ),
      ),
      body: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 37, 54, 101),
          ),
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Add Vehicle",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries,",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  height: screenHeight * 0.7,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Column(
                      children: [
                        SizedBox(height: 32),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 37, 54, 101),
                            ),
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          margin: EdgeInsets.only(left: 20, right: 20),
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(
                              left: 20, right: 20, top: 5, bottom: 5),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            borderRadius: BorderRadius.circular(30),
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 37, 54, 101),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down),
                            value: vehicleTypeValue,
                            onChanged: (newValue) {
                              setState(() {
                                vehicleTypeValue = newValue!;
                              });
                            },
                            items: items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Row(
                                  children: [
                                    Icon(icons[value]),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(value),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 37, 54, 101),
                              ),
                              labelText: 'Vehicle no',
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: Icon(CupertinoIcons.number_square),
                              prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              labelText: 'Vehicle Model',
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: Icon(Icons.car_crash),
                              prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 37, 54, 101),
                              ),
                              labelText: 'Vehicle Color',
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: Icon(Icons.color_lens),
                              prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: TextField(
                            maxLines: 2,
                            textAlignVertical: TextAlignVertical.top,
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              labelText: 'Note (Optional)',
                              labelStyle: TextStyle(
                                color: Color.fromARGB(255, 37, 54, 101),
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(255, 255, 255, 255),
                              prefixIcon: Icon(Icons.note),
                              prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/home');
                            },
                            child: Text(
                              "Add Vehicle",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 37, 54, 101),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.only(top: 16, bottom: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          )),
    );
  }
}
