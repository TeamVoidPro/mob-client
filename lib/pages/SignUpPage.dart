import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  bool _value = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 37, 54, 101),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Clickable Icon
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
          ],
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
                          "Sign Up",
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
                  height: 600,
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
                              floatingLabelStyle: TextStyle(
                                color: Color.fromARGB(255, 37, 54, 101),
                              ),
                              labelText: 'Username',
                              filled: true,
                              fillColor: Color.fromARGB(255, 217, 217, 217),
                              prefixIcon: Icon(Icons.person),
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
                              labelText: 'Email',
                              filled: true,
                              fillColor: Color.fromARGB(255, 217, 217, 217),
                              prefixIcon: Icon(Icons.email),
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
                              labelText: 'Password',
                              filled: true,
                              fillColor: Color.fromARGB(255, 217, 217, 217),
                              prefixIcon: Icon(Icons.lock),
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
                              labelText: 'Confirm Password',
                              filled: true,
                              fillColor: Color.fromARGB(255, 217, 217, 217),
                              prefixIcon: Icon(Icons.lock),
                              prefixIconColor: Color.fromARGB(255, 37, 54, 101),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              // Checkbox to agree to terms and conditions
                              Checkbox(
                                visualDensity: VisualDensity.standard,

                                value: _value,
                                // change the size of the checkbox
                                onChanged: (value) {
                                  setState(() {
                                    _value = value!;
                                  });
                                },
                                // Make checkbox larger
                                side: BorderSide(
                                  width: 2,
                                  color: Color.fromARGB(255, 37, 54, 101),
                                ),
                                activeColor: Color.fromARGB(255, 37, 54, 101),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "I agree to",
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 37, 54, 101),
                                    ),
                                  ),
                                  TextButton(onPressed: (){}, child:
                                    Text(
                                      "Terms and Conditions",
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 37, 54, 101),
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "/add-vehicle");
                            },
                            child: Text(
                              "Sign Up",
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
                  ))
            ],
          )),
    );
  }
}
