import 'package:flutter/material.dart';

import '../components/HalfCircleClipperTopLeft.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: 200, // Adjust the width and height according to your needs
            height: 200,
            child: ClipPath(
              clipper: HalfCircleClipperTopLeft("top-left"),
              child: Container(
                color: Color.fromARGB(255, 37, 54, 101),
              ),
            ),
          ),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                  image: AssetImage('assets/Images/welcome.png'),
                  width: 200,
                  height: 200),
            ],
          )),
          Positioned(
              bottom: 0,
              left: 0,
              height: 300,
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 37, 54, 101),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: Column(children: [
                  SizedBox(height: 32),
                  Text(
                    "WELCOME",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec eget leo vel nunc ultricies ultrices. Donec euismod, nisl eget aliquam ultricies,  ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 24),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Sign In',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 0, 116, 217),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 255, 255, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 24),
                    ],
                  )
                ]),
              ))
        ],
      ),
    );
  }
}
