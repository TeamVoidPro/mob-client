import 'package:flutter/material.dart';

class ThankYou extends StatefulWidget {
  final String msgString;
  const ThankYou({required this.msgString, super.key});

  @override
  State<ThankYou> createState() => _ThankYou();
}

class _ThankYou extends State<ThankYou> {
  int _rating = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/book/payment');
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 0),
            child: Center(
              child: Image(image: AssetImage("assets/Images/thankYou.png")),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Text(
                    "Have a nice day!",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Center(
              child: Text(
                "Rate the " + widget.msgString,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          // Rating 5 stars
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 1; i <= 5; i++)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _rating = i;
                        });
                      },
                      icon: Icon(
                        _rating >= i ? Icons.star : Icons.star_border,
                        color: Color.fromARGB(255, 253, 204, 13),
                        size: 40,
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),

          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 37, 54, 101),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                child: Text('Back to Home')
            ),
          ),
        ],
      ),
    );
  }
}
