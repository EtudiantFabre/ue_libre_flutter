import 'dart:convert';
import 'dart:io';

import 'package:connection_vers_la_base/constante.dart';
import 'package:connection_vers_la_base/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';
import 'home.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordConfirmationController = TextEditingController();


  void login(String email, name, password, passwordConfirmationController) async{
    try{
      Response response = await post(
        Uri.parse('$baseUrl/register'),
        body: {
          'name': name,
          'email' : email,
          'password': password,
          'password_confirmation': passwordConfirmationController
        }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body.toString());
        print("Voici le token :" + data['token']);
        print(data['user']['id']);

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Félicitation ! Vous avez un compte."),
        ));

        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString('token', data['token'] ?? '');
        await pref.setInt('userId', data['user']['id'] ?? 0);

        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()), (route) => false);

        /*print("Voici le token :" + data['token']);
        print("Votre compte à été créer avec succès");*/
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Erreur : compte non créer !"),
        ));
        print('failed');
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Erreur : Connection vers la base échoué !"),
      ));

      print(e.toString());
    }
  }


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("CRÉATION DE COMPTE"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.name,
              controller: nameController,
              validator: (val) => val!.isEmpty ? 'Nom invalide !' : null,
              decoration: const InputDecoration(
                hintText: "Name",
                labelText: 'Nom',
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.orange))
              ),
            ),
            SizedBox(height: 20,),
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
            SizedBox(height: 20,),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              controller: passwordConfirmationController,
              obscureText: true,
              validator: (val) => val!.isEmpty ? 'Mot de passe invalide !' : null,
              decoration: const InputDecoration(
                hintText: "Confirm password",
                labelText: "Password confirm",
                contentPadding: EdgeInsets.all(10.0),
                border: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.orange))
              ),
            ),
            SizedBox(height: 40,),
            /*OverflowBox(
              minHeight: 0.0,
              minWidth: 0.0,
              maxWidth: double.infinity,
              maxHeight: double.infinity,
            ),*/
            TextButton(
              onPressed: (){
                login(emailController.text.toString(), nameController.text.toString(), passwordController.text.toString(), passwordConfirmationController.text.toString());
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.brown),
                  padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.symmetric(vertical:20)),
              ),
              child: const Center(
                child: Text(
                  "Créer mon compte",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            /*Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(30)
              ),
              child: Center(
                child: Text("Créer mon compte"),
              ),
            ),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(), nameController.text.toString(), passwordController.text.toString(), passwordConfirmationController.text.toString());
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.brown,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: const Center(
                  child: Text("Créer mon compte"),
                ),
              ),
            ),*/
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
      ),
    );
  }
}
