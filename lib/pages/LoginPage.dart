import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/FormComponent/InputText.dart';
import '../models/Driver.dart';
import '../providers/userProvider.dart';
import '../sevices/GoogleServices.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // TODO : Remove before push
    _emailController.text = 'sstdinushan@gmail.com';
    _passwordController.text = 'dinushan7727';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _submit() {
    setState(() {
      _isLoading = true;
    });
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _formKey.currentState!.save();
    _login(_emailController.text, _passwordController.text).then((bool value) async {
      if(value){
        setState(() {
          _isLoading = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Success'),
            backgroundColor: Colors.green,
          )
        );
        Navigator.pushNamed(context, '/home');
        // Navigator.pushNamed(context, '/');
      }else{
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login failed'),
            backgroundColor: Colors.red,
          ),
        );
      }

    });
  }

  Future<bool> _login(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://10.0.2.2:7211/api/Driver/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      final userDataProvider = Provider.of<userProvider>(context, listen: false);
      print(response.data);
      Driver driver= Driver.fromJson(response.data['driver']);

      String token = response.data['token'];
      userDataProvider.setUser(driver);
      userDataProvider.setToken(token);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    const white = Color.fromARGB(255, 255, 255, 255);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 37, 54, 101),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text(
                "Sign Up",
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
            Navigator.pushNamed(context, '/welcome');
          },
        ),
      ),
      body:Stack(
        children: [
          Container(
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
                      height: screenHeight * 0.25,
                      child: Column(
                        children: [
                          Container(
                            height: screenHeight * 0.05,
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              "Enter your email and password to access your account or create a new account.",
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
                      height: screenHeight * 0.75,
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 32),
                              inputText(
                                  controller: _emailController,
                                  labelText: "Email",
                                  icon: Icons.email,
                                  hintText: 'Enter your email',
                                  width: MediaQuery.of(context).size.width,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  }),
                              SizedBox(height: 16),
                              inputText(
                                  controller: _passwordController,
                                  labelText: "Password",
                                  icon: Icons.lock,
                                  obscureText: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  hintText: 'Enter your password',
                                  width: MediaQuery.of(context).size.width,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  }
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Forgot Password?",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: ElevatedButton(
                                  onPressed: _submit,
                                  child: Text(
                                    "Sign In",
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
                              SizedBox(height: 48),
                              // "Or" Text
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 16),
                                    Text(
                                      "Or",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 16),
                                    Container(
                                      width: 100,
                                      height: 1,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 48),
                              // Continue with Google
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    SignInWithGoogle();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/Icons/Google.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        "Continue with Google",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.only(top: 16, bottom: 16),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/Icons/Facebook.png",
                                        width: 24,
                                        height: 24,
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        "Continue with Facebook",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    padding: EdgeInsets.only(top: 16, bottom: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              )),
          _isLoading ?
          Positioned(
              top: 0,
              left:0,
              bottom: 0,
              right:0,
              child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(100, 0, 0, 0),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height ,
            child: CircularProgressIndicator(),
          )
          ) :
              SizedBox()
        ],
      )

    );
  }
}
