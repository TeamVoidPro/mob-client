import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mob_client/components/FormComponent/InputText.dart';
import 'package:mob_client/utils/Navigation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Driver.dart';
import '../providers/userProvider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {

  bool _value = false;
  final Dio _dio = Dio();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dummyData();

  }

  void dummyData(){
    _emailController.text = 'sstdinushan@gmail.com';
    _passwordController.text = 'dinushan7727';
    _confirmPasswordController.text = 'dinushan7727';
    _firstNameController.text = 'Dinushan';
    _lastNameController.text = 'Sivakumar';
    _phoneController.text = '0771234567';
  }


  // Terms and Conditions Dialog
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Conditions"),
          content: const Text("This is the terms and conditions"),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        Object? data = {
    "email": _emailController.text,
    "password": _passwordController.text,
    "confirmPassword": _confirmPasswordController.text,
    "firstName": _firstNameController.text,
    "lastName": _lastNameController.text,
    "contactNumber": _phoneController.text,
    };
        print(data);
        final response = await _dio.post(
          'https://parkease.azurewebsites.net/api/Driver/register',
          data: data
        );



        // If server returns an OK response navigate to Login Page else show error
        if (response.statusCode == 200) {
          // final userDataProvider = Provider.of<userProvider>(context, listen: false);
          final userDataProvider = context.read<userProvider>();
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Driver driver= Driver.fromJson(response.data['driver']);
          String token = response.data['token'];
          userDataProvider.setUser(driver);
          userDataProvider.setToken(token);
          Navigation.push('/add-vehicle');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response.data['message']),
              backgroundColor: Colors.red,
            ),
          );
        }

      } catch (e) {
        print(e);
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 37, 54, 101),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                "Sign In",
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
      body: Container(
          height: double.infinity,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 37, 54, 101),
          ),
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
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
                  height: screenHeight * 0.60,
                  child:
                  Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: const Text(
                              "Enter your details",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              inputText(
                                controller: _firstNameController,
                                labelText: "First Name",
                                keyboardType: TextInputType.name,
                                hintText: "Enter your first name",
                                icon: Icons.person,
                                width: MediaQuery.of(context).size.width * 0.5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  return null;
                                },
                              ),
                              inputText(
                                controller: _lastNameController,
                                labelText: "Last Name",
                                keyboardType: TextInputType.name,
                                hintText: "Enter your last name",
                                icon: Icons.person,
                                width: MediaQuery.of(context).size.width * 0.5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          inputText(
                            controller: _emailController,
                            labelText: "Email",
                            keyboardType: TextInputType.emailAddress,
                            hintText: "Enter your email",
                            icon: Icons.email,
                            width: MediaQuery.of(context).size.width,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          inputText(
                            controller: _phoneController,
                            labelText: "Phone",
                            keyboardType: TextInputType.phone,
                            hintText: "Enter your phone number",
                            icon: Icons.phone,
                            width: MediaQuery.of(context).size.width,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your phone number';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              inputText(
                                controller: _passwordController,
                                labelText: "Password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                hintText: "Enter your password",
                                icon: Icons.lock,
                                width: MediaQuery.of(context).size.width * 0.5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                              inputText(
                                controller: _confirmPasswordController,
                                labelText: "Confirm Password",
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: true,
                                hintText: "Enter your password",
                                icon: Icons.lock,
                                width: MediaQuery.of(context).size.width * 0.5,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: ElevatedButton(
                              onPressed: () {
                                _submit();
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color.fromARGB(255, 37, 54, 101),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: EdgeInsets.only(top: 16, bottom: 16),
                              ),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
