import 'package:flutter/material.dart';

const baseUrl = "http://localhost:8000/api";

const loginURL = baseUrl + '/login';
const registerURL = baseUrl + '/register';
const logoutURL = baseUrl + '/logout';
const userURL = baseUrl + '/user';
const postsURL = baseUrl + '/posts';
const groupesURL = baseUrl + '/groupes';
const commentsURL = baseUrl + '/comments';

// ----- Errors -----
const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = 'Something went wrong, try again!';


// Button
TextButton kTextButton(String label, Function onPressed){
  return TextButton(
      onPressed: () => onPressed(),
      child: Text(
        "Login",
        style: TextStyle(color: Colors.brown),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
        padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical:10))
      ),
  );
}