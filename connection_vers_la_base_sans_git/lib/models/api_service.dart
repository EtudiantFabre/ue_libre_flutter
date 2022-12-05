import 'dart:convert';
import 'dart:io';
import 'dart:js';

import 'package:connection_vers_la_base/constante.dart';
import 'package:connection_vers_la_base/models/groupe.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<List<Groupe>?> getGroupe() async {
  try {
    Response response = await post(
        Uri.parse('$baseUrl/groupes'),
        headers: {
          'Accept' : 'application/json'
        }
    );
    if(response.statusCode == 200){
      var data = jsonDecode(response.body);
      print("Voici le token :" + data['token']);
      //0
      // List<Groupe> groupes = data.toString();
      //print(data['groupes']['id']);


    } else {
      print('failed');
    }
  } catch(e) {
    e.toString();
  }
}
