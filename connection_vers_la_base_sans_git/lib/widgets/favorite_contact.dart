
import 'dart:convert';

import 'package:connection_vers_la_base/constante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoriteContact extends StatefulWidget {
  const FavoriteContact({Key? key}) : super(key: key);

  @override
  State<FavoriteContact> createState() => _FavoriteContactState();
}

class _FavoriteContactState extends State<FavoriteContact> {
  List<dynamic> listeGroupes = [];

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
      listeGroupes = data["groupes"];
      print(listeGroupes);

      // Use the compute function to run parsePhotos in a separate isolate.
    } else{
      print("Erreur pour groupe");
    }
    //return await response.statusCode == 200 ? parseGroupe(response.body) : [];
  }

  @override
  void initState() {
    super.initState();
    fetchGroupe();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("Favoris", style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.0,
                ),),
                IconButton(icon: Icon(Icons.more_horiz), onPressed: (){},),
              ],
          ),
        ),
        Container(
          height: 120.0,
          color: Colors.blueGrey,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 15.0, top: 20.0),
            scrollDirection: Axis.horizontal,
            itemCount: listeGroupes.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    /*CircleAvatar(
                      radius: 35.0,
                      backgroundColor: Colors.orange,
                    ),*/
                    Icon(
                      Icons.account_balance_rounded,
                      size: 25.0,
                      color: Colors.amber,
                    ),
                    Text(listeGroupes[index]["nom_gpe"],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
