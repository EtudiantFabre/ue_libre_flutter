import 'dart:convert';

import 'package:connection_vers_la_base/constante.dart';
import 'package:connection_vers_la_base/models/groupe.dart';
import 'package:connection_vers_la_base/services/groupe_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategorySelector extends StatefulWidget {
  const CategorySelector({Key? key}) : super(key: key);

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final List<String> listeGroupe = ["Groupe", "Proclamateur", "Rapport"];
  int selectedIndex = 0;


  /*List<Groupe> parseGroupe(String responseBody) {
    final listeGroupe = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return listeGroupe.map<Groupe>((json) => Groupe.fromJson(json)).toList();
  }*/

  Future<void> fetchGroupe() async {
    final response = await http.get(
      Uri.parse('$groupesURL'),
    );

    if (await response.statusCode == 200){
      /*setState(() {
        listeGroupe = jsonDecode(response.body).cast<Map<String, dynamic>() as List<dynamic>;
        print("Voici listeGroupe : " + listeGroupe.toString());
      });*/
      var data = jsonDecode(response.body);
      print(data["groupes"][0]);
      //listeGroupe = data["groupes"];
      print(listeGroupe);

      // Use the compute function to run parsePhotos in a separate isolate.
    } else{
      print("Erreur pour groupe");
    }
    //return await response.statusCode == 200 ? parseGroupe(response.body) : [];
  }

  @override
  void initState() {
    fetchGroupe();
    super.initState();
  }

  //late Future<List<Groupe>> categories => fetchGroupe();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.0,
      color: Theme.of(context).primaryColor,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: listeGroupe.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });
            },
            child: Padding(
              padding:const EdgeInsets.symmetric(
                horizontal: 35.0,
                vertical: 30.0,
              ),
              child: Text(
                listeGroupe[index],
                style: TextStyle(
                  color: index == selectedIndex ? Colors.white : Colors.white60,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
