import 'package:connection_vers_la_base/login.dart';
import 'package:connection_vers_la_base/services/groupe_service.dart';
import 'package:connection_vers_la_base/widgets/category_selector.dart';
import 'package:connection_vers_la_base/widgets/favorite_contact.dart';
import 'package:connection_vers_la_base/widgets/recent_groupe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<bool> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.reload();
    return await pref.remove('token');
  }

  @override
  void initState() {
    fetchGroupe();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          iconSize: 30.0,
          color: Colors.white,
          onPressed: (){},
        ),
        title: const Text(
          "Chats",
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: (){
              logout().then((value) => {
                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false)
              });
            },
          ),
        ],
      ),
      /*body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                "Hello! Vous êtes connecté avec succès.",
                style: TextStyle(
                  fontSize: 38.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
            ),
          ],
        ),
      ),*/
      body: Column(
        children: <Widget>[
          CategorySelector(),
          Expanded(
            child: Container(
              height: 500.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  FavoriteContact(),
                  RecentGroupe(),
                ],
              ),
            ),
          ),
        ],
      ),
      // body

      /*body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              validator: (val) => val!.isEmpty ? 'Nom invalide !' : null,
              decoration: const InputDecoration(
                  hintText: "Name",
                  labelText: 'Nom',
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.orange))
              ),
            ),
            SizedBox(height: 20,),

            GestureDetector(
              onTap: (){
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: const Center(
                  child: Text("Créer mon compte"),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("J'ai déjà un compte ! "),
                GestureDetector(
                  child: Text("Se connecter", style: TextStyle(color: Colors.blue)),
                  onTap: (){
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                  },
                )
              ],
            )
          ],
        ),
      ),*/

    );
  }
}
