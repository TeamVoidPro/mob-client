import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mob_client/utils/Request.dart';
import 'package:provider/provider.dart';

import '../models/Driver.dart';
import '../providers/userProvider.dart';

class AddVehiclePage extends StatefulWidget {
  const AddVehiclePage({super.key});

  @override
  State<AddVehiclePage> createState() => _AddVehiclePage();
}

class _AddVehiclePage extends State<AddVehiclePage> {
  bool _value = false;

  // Create a DropDown list
  String? vehicleTypeValue;

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

  final Dio _dio = Dio();

  //Form Key
  final _formKey = GlobalKey<FormState>();

  // Controllers
  TextEditingController _vehicleNumberController = TextEditingController();
  TextEditingController _vehicleModelController = TextEditingController();
  TextEditingController _vehicleColorController = TextEditingController();
  TextEditingController _vehicleNoteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _vehicleNumberController.text = 'AAB-1234';
    _vehicleModelController.text = 'Toyota';
    _vehicleColorController.text = 'Red';
    _vehicleNoteController.text = 'This is a note';
  }


  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final userDataProvider = context.read<userProvider>();
      Driver driver = userDataProvider.user!;
      print(driver.driverId);
      if (vehicleTypeValue == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Color.fromARGB(200, 255,0,0),
            content: Text('Please select a vehicle type'),
          ),
        );
      } else {
        var response = await sendAuthPOSTRequest('add-vehicle', {
          "driverId": driver.driverId,
          "vehicleNumber": _vehicleNumberController.text,
          "vehicleType": vehicleTypeValue,
          "vehicleColor": _vehicleColorController.text,
          "vehicleModel": _vehicleModelController.text,
          "additionalNotes": _vehicleNoteController.text,
        }
        );
        if(response!=null){
          if(response.statusCode == 200){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Color.fromARGB(200, 1, 121, 1),
                content: Text('Vehicle added successfully'),
              ),
            );

          }else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: const Color.fromARGB(200, 255,0,0),
                content: Text(response.data),
              ),
            );
          }
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Color.fromARGB(200, 255,0,0),
              content: Text('Something went wrong'),
            ),
          );
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color.fromARGB(200, 255,0,0),
          content: Text('Please fill all the required fields'),
        ),
      );
    }
  }






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
      body:
      SafeArea(
        child: Container(
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
                      child:
                      Form(
                        key: _formKey,
                        child:
                        Column(
                          children: [
                            const SizedBox(height: 16),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Enter Vehicle Details",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 37, 54, 101),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16),
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
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 5, bottom: 5),
                              child:
                              DropdownButtonFormField<String>(
                                isExpanded: true,
                                hint: Text(
                                  "Select Vehicle Type",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 37, 54, 101),
                                  ),
                                ),
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                                icon: const Icon(Icons.keyboard_arrow_down),
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(icons[value]),
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
                              child: TextFormField(
                                controller: _vehicleNumberController,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter vehicle number';
                                  }
                                  return null;
                                },
                              ),

                            ),
                            SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _vehicleModelController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 37, 54, 101),
                                    ),
                                  ),
                                  labelText: 'Vehicle Model',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 255, 255, 255),
                                  prefixIcon: Icon(Icons.car_crash),
                                  prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter vehicle model';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: _vehicleColorController,
                                obscureText: false,
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter vehicle color';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 16),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                maxLines: 2,
                                controller: _vehicleNoteController,
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
                                onPressed:_onSubmit,
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
                    )
                ),
              ],
            )),
      ),
    );
  }
}
