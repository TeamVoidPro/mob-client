import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPaymentPage extends StatefulWidget {
  const BookingPaymentPage({super.key});

  @override
  State<BookingPaymentPage> createState() => _BookingPaymentPage();
}

class _BookingPaymentPage extends State<BookingPaymentPage> {
  String _paymentMethod = 'Card';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _paymentMethod = 'Card';
  }

  void handlePaymentMethodChange(String? value) {
    setState(() {
      _paymentMethod = value ?? 'Card';
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
                  Navigator.pushNamed(context, '/welcome');
                },
              ),
            ],
            leading: IconButton(
              icon: const Icon(
                Icons.keyboard_arrow_left,
                size: 30,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/book');
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
                          "Oct 30 10:15 AM",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(255, 37, 54, 101),
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Change",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 37, 54, 101)),
                                ),

                              ],
                            )
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
                          "Duration ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "10:15 AM - 12.15 PM",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(255, 37, 54, 101),
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Change",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 37, 54, 101)),
                                ),

                              ],
                            )
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
                          "Vehicle Details ",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          children: [
                            Text(
                              "Suzuki Swift",
                              style: TextStyle(fontSize: 14),
                            ),
                            Text(
                              "CA 1234",
                              style: TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(255, 37, 54, 101),
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Change",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 37, 54, 101)),
                                ),

                              ],
                            )
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
                          "Level 2, Lot 2",
                          style: TextStyle(fontSize: 14),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: const Color.fromARGB(255, 37, 54, 101),
                                  size: 16,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "Change",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(
                                          255, 37, 54, 101)),
                                ),

                              ],
                            )
                        )

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
                          "LKR 400.00",
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
                                hintText: 'Enter Card Number',
                              ),
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
                            Navigator.pushNamed(context, '/success');
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
                  ],
                )),
          )

        ));
  }
}
