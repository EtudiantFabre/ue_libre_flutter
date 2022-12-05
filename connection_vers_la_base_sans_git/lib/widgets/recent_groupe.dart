import 'package:connection_vers_la_base/models/groupe.dart';
import 'package:connection_vers_la_base/services/groupe_service.dart';
import 'package:flutter/material.dart';

class RecentGroupe extends StatefulWidget {
  const RecentGroupe({Key? key}) : super(key: key);


  @override
  State<RecentGroupe> createState() => _RecentGroupeState();
}

class _RecentGroupeState extends State<RecentGroupe> {

  @override
  void initState() {
    super.initState();
    fetchGroupe();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ListView.builder(
          itemCount: listeGroupes.length,
          itemBuilder: (BuildContext context, int index) {
            final Groupe grpe = listeGroupes[index];
            return Row(
              children: <Widget>[
                Text(
                  grpe.toString(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
