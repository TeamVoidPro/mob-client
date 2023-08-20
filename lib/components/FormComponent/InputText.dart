

import 'package:flutter/material.dart';

Widget inputText({
  required TextEditingController controller,
  required String labelText,
  required String hintText,
  required IconData icon,
  required double width,
  required String? Function(String?)? validator,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  bool enabled = true,
  bool autofocus = false,
  bool autocorrect = false,
  bool enableSuggestions = false,
  bool readOnly = false,

})
{
  return Container(
    width: width,
    padding: EdgeInsets.only(left: 10, right: 10),
    child: TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: autocorrect,
      autofocus: autofocus,
      enableSuggestions: enableSuggestions,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 10,bottom: 0,top: 5),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            width: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        border: UnderlineInputBorder(
          borderSide: const BorderSide(
            width: 3.0,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            width: 3.0,
            color: Color.fromARGB(255, 37, 54, 101),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        floatingLabelStyle: const TextStyle(
          color: Color.fromARGB(255, 37, 54, 101),
        ),
        labelText:  labelText,
        hintStyle: TextStyle(
          color: Color.fromARGB(255, 37, 54, 101),
        ),
        filled: true,
        fillColor: Color.fromARGB(255, 255, 255, 255),
        prefixIcon: Icon(
          icon,
          color: Color.fromARGB(255, 37, 54, 101),
        ),
        prefixIconColor: Color.fromARGB(255, 37, 54, 101),
      ),
      validator: validator,

    ),
  );
}