import 'dart:convert';

import 'package:connection_vers_la_base/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async{
    try{
      Response response = await post(
          Uri.parse('http://10.42.0.39:8000/api/login'),
          body: {
            'email' : email,
            'password': password,
          }
      );
      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print("Voici le token :" + data['token']);
        print(data['user']['id']);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Vous êtes connecter avec succès !"),
        ));

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('token', data['token'] ?? '');
        await pref.setInt('userId', data['user']['id'] ?? 0);

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);

        /*print("Voici le token :" + data['token']);
        print("Votre compte à été créer avec succès");*/
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erreur : email ou mot de passe incorect !"),
        ));
        print('failed');
      }
    } catch(e) {
      e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.connected_tv_sharp),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: (){

            },
          ),
          title: Text(
            "CONNEXION",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailController,
              validator: (val) => val!.isEmpty ? 'Adresse email invalide !' : null,
              decoration: const InputDecoration(
                  hintText: "Email",
                  labelText: 'Email',
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.orange))
              ),
            ),
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordController,
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Mot de passe invalide !' : null,
              decoration: const InputDecoration(
                  hintText: "Password",
                  labelText: 'Password',
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.orange))
              ),
            ),
            SizedBox(height: 40,),
            TextButton(
                onPressed: (){
                  login(emailController.text.toString(), passwordController.text.toString());
                },
                child: Text(
                  "Connection",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.brown),
                  padding: MaterialStateProperty.resolveWith(
                          (states) => EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 40,
                          )
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
