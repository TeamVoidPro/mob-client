import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mob_client/utils/Request.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:math';

import 'SuccessPage.dart';

class BookingPaymentPage extends StatefulWidget {
  final String ArrivingDate;
  final String DepartureDate;
  final String Duration;
  final String VehicleDetails;
  final String ParkingLocation;
  final String ParkingPlaceID;
  final String TotalAmount;
  final String ZoneID;

  const BookingPaymentPage({Key? key, required this.ArrivingDate, required this.DepartureDate, required this.Duration, required this.VehicleDetails, required this.ParkingLocation, required this.TotalAmount, required this.ParkingPlaceID, required this.ZoneID}) : super(key: key);

  @override
  State<BookingPaymentPage> createState() => _BookingPaymentPage();
}

class _BookingPaymentPage extends State<BookingPaymentPage> {
  String _paymentMethod = 'Card';
  Map<String, dynamic>? paymentIntent;
  final _testCard = {
    'cardNumber': '4242424242424242',
    'expMonth': 04,
    'expYear': 24,
    'cvc': '242',
  };
  //text Controllers
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentMethod = 'Card';
  }


  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': amount,
        'currency': currency,
      };

      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }
  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {

        //Clear paymentIntent variable after successful payment
        print('Payment Successful');

      })
          .onError((error, stackTrace) {
            print('Error is:---> $error');
        throw Exception(error);
      });
    }
    on StripeException catch (e) {
      print('Error is:---> $e');
    }
    catch (e) {
      print('$e');
    }
  }

  Future<void> makePayment() async {
    try {
      //STEP 1: Create Payment Intent
      paymentIntent = await createPaymentIntent("500", "LKR");

      var gpaymentIntent = const PaymentSheetGooglePay(
        //Sri Lanka
          merchantCountryCode: "LK",
          currencyCode: "LKR",
          testEnv: true
      );
      print(paymentIntent!['client_secret']);

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(

          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent![
              'client_secret'], //Gotten from payment intent
              style: ThemeMode.dark,
              merchantDisplayName: 'ParkEase',
              googlePay: gpaymentIntent,
          ));

      //STEP 3: Display Payment sheet
      displayPaymentSheet();
    } catch (err) {
      print("Payment Error: ${err.toString()}");
      throw Exception(err);
    }
  }

  void handlePaymentMethodChange(String? value) {
    setState(() {
      _paymentMethod = value ?? 'Card';
    });
  }

  void GetPayment(BuildContext context) {
    // Show loading indicator
    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator(),), barrierDismissible: false,);
    // Delay 3 seconds to simulate a load
    Future.delayed(const Duration(seconds: 3), () async {
      // Navigator.pushNamed(context, '/success');
      // valiaate with test card
      if (_cardNumberController.text == _testCard['cardNumber']) {


      //get reservation
        Object data = {
          "zoneId" :widget.ZoneID,
          "reservationStartTime" :DateTime.parse(widget.ArrivingDate).toIso8601String(),
          "reservationEndTime" : DateTime.parse(widget.DepartureDate).toIso8601String(),
          "parkingPlaceId" : widget.ParkingPlaceID,
          "totalPayment" : double.parse(widget.TotalAmount),
          "paymentMethod" : "Card"
        };
        print(data);
        var res = await sendAuthPOSTRequest("/make-reservation",data);
        Map<String, dynamic> response = jsonDecode(res.toString());
        var SlotID = response["slot"];

        // Hide loading indicator
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              SuccessPage(
                  ParkingLocation:widget.ParkingLocation,
                  SlotID: SlotID,
              )),
        );
      } else {
        // Hide loading indicator
        Navigator.pop(context);
        // show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            title: const Text("Reservation Details"),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.info),
                onPressed: () {
                  // Navigator.pop(context);
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 30,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/book');
                Navigator.pop(context);
              },
            ),
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: const Color.fromARGB(255, 207, 207, 207),
                height: 2.0,
              ),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
               constraints: BoxConstraints(
                 minHeight: MediaQuery.of(context).size.height - 100,
               ),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Arriving Date ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(widget.ArrivingDate)),
                          style: TextStyle(fontSize: 14),
                        ),

                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Departure Date ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.parse(widget.DepartureDate)),
                          style: TextStyle(fontSize: 14),
                        ),

                      ],
                    ),
                    SizedBox(height: 10),
                    // Line Separator
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Duration ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${widget.Duration} Hours",
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Line Separator
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Vehicle Details ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.VehicleDetails,
                          style: TextStyle(fontSize: 14),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    // Line Separator
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Parking Location ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.ParkingLocation,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    // Line Separator
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Total Amount :",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 20),
                        Text(
                          "LKR ${widget.TotalAmount}",
                          style: TextStyle(fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    // Line Separator
                    Container(
                      color: const Color.fromARGB(255, 207, 207, 207),
                      height: 1.0,
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Payment Method",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 400,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RadioListTile(
                              value: 'Card',
                              groupValue: _paymentMethod,
                              onChanged: handlePaymentMethodChange,
                              fillColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 37, 54, 101)),
                              activeColor: Colors.blue,
                              selectedTileColor: Color.fromARGB(255, 37, 54, 101),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(image: AssetImage('assets/Images/visa.png'),
                                    height: 30,
                                    width: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Credit/Debit Card Payment",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )
                          ),
                          RadioListTile(
                              value: 'Cash',
                              groupValue: _paymentMethod,
                              onChanged: handlePaymentMethodChange,
                              fillColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 37, 54, 101)),
                              activeColor: Colors.blue,
                              selectedTileColor: Color.fromARGB(255, 37, 54, 101),
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(image: AssetImage('assets/Images/cash.png'),
                                    height: 30,
                                    width: 50,
                                  ),
                                  SizedBox(width: 10),
                                  Text(
                                    "Cash Payment",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    if (_paymentMethod == 'Card')
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Card Number",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold
                                ),


                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 400,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Card Number',
                              ),
                              controller: _cardNumberController,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Card Holder Name",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: 400,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Card Holder Name',
                              ),
                              controller: _cardHolderNameController,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Expiry Date",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 250,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'MM/YY',
                                      ),
                                      controller: _expiryDateController,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    "CVV",
                                    style: TextStyle(
                                        fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    width: 100,
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'CVV',
                                      ),
                                      controller: _cvvController,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/success');
                            GetPayment(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 37, 54, 101)),
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(50, 10, 50, 10)),
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Pay Now ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                                  backgroundColor: const Color.fromARGB(255, 37, 54, 101),
                                ),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/success');
                            makePayment();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 192, 34, 124)),
                            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(50, 10, 50, 10)),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.payment,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Google Pay ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: const Color.fromARGB(255, 255, 255, 255),
                              )
                              ),
                            ],
                          ),

                        ),
                      ],
                    ),
                  ],
                )),
          )

        ));
  }
}
