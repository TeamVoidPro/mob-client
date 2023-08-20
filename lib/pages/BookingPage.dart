
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({super.key});

  @override
  State<BookingPage> createState() => _BookingPage();
}

class _BookingPage extends State<BookingPage> {

  // Define Array of cards
  int _selectedICard = -1;

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

    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_left,
              size: 30,
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Image(image: AssetImage('assets/Images/vehiclePark.png')),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
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
                                    side: const BorderSide(color: Colors.black)))),
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
                              'google.navigation:q=6.890128,79.860594&key=AIzaSyDQ1BEqGpYixqC1UYfnkO-EluckHFwWegE'
                            )
                          );
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
                    const Row(
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
                    const SizedBox(height: 10),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                            "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, "
                            "when an unknown printer took a galley of type and scrambled it to make a type specimen book."
                            " It has survived not only five centuries,",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 10),
                    const Row(
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
                    const SizedBox(height: 10),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. "
                            "Lorem Ipsum has been the industry's standard dummy text ever ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    const SizedBox(height: 10),
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
                                    duration: const Duration(milliseconds: 500),
                                    opacity: _selectedICard == i ? 1.0 : 0.5,
                                    child:
                                    Stack(
                                      children: [
                                        Container(
                                          width: 150,
                                          height: 80,
                                          padding: const EdgeInsets.all(5),
                                          margin: const EdgeInsets.only(right: 10,top: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: const Color.fromARGB(255, 37, 54, 101),
                                              width: 2,
                                            ),
                                          ),
                                          child:
                                          const Column(
                                            children: <Widget>
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
                                            top: 5,
                                            right: 5,
                                            child:
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 38, 194, 129),
                                                borderRadius: BorderRadius.circular(100),
                                                border: Border.all(
                                                  color: const Color.fromARGB(255, 38, 194, 129),
                                                  width: 2,
                                                ),
                                              ),
                                              child: const Icon(Icons.check, color: Colors.black, size: 20),
                                            ),
                                          ),
                                      ],
                                    )
                                )
                            )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Reserve Button
                    TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, '/book/payment');
                        },

                        child:
                        Container(
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
                          child: const Row(
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
        )
      ),
    );
  }
}
