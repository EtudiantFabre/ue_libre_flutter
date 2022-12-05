// A function that converts a response body into a List<Photo>.
import 'dart:convert';
import 'dart:io';
import 'package:connection_vers_la_base/constante.dart';
import 'package:connection_vers_la_base/services/user_service.dart';
import 'package:http/http.dart' as http;
import 'package:connection_vers_la_base/models/groupe.dart';

List<Groupe> parseGroupe(String responseBody) {
  final listeGroupe = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return listeGroupe.map<Groupe>((json) => Groupe.fromJson(json)).toList();
}

/*Future<List<Groupe>> fetchGroupe(http.Client client) async {
  final response = await client
      .get(Uri.parse('$groupesURL'), headers: {
    HttpHeaders.authorizationHeader : '$getToken()'
  });


  if (await response.statusCode == 200){
    var data = jsonDecode(response.body);
    print(data);
  } else{
    print(token);
    print("Erreur pour groupe");
  }
  // Use the compute function to run parsePhotos in a separate isolate.
  return parseGroupe(response.body);
}*/

/*
Future<List<Groupe>> fetchGroupe() async {
  //reloadPref();
  print("Je suis là !!!");
  print(await getToken());
  final response = await http.get(
    Uri.parse('$groupesURL'),
    // Send authorization headers to the backend.
    headers: {
      HttpHeaders.authorizationHeader: '$token',
    },
  );

  if (await response.statusCode == 200){
    var data = jsonDecode(response.body);
    print(data);

    // Use the compute function to run parsePhotos in a separate isolate.
  } else{
    print("Erreur pour groupe");
  }
  return await response.statusCode == 200 ? parseGroupe(response.body) : [];
}*/


List<dynamic> listeGroupes = [];

Future<List> fetchGroupe() async {
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
  return response.statusCode == 200 ? listeGroupes : [];
}