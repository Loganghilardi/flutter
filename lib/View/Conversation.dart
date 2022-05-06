import 'package:firstapplicationeisi/Controller/MessageController.dart';
import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/View/AllUsers.dart';
import 'package:firstapplicationeisi/View/MyUsers.dart';
import 'package:firstapplicationeisi/library/constant.dart';
import 'package:firstapplicationeisi/main.dart';
import 'package:firstapplicationeisi/model/MyProfil.dart';
import 'package:firstapplicationeisi/model/Utilisateur.dart';
import 'package:firstapplicationeisi/modelView/ZoneTexte.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
  late MyProfil partner;
  Conversation({required this.partner});
  @override
  State<Conversation> createState(){
    return ConversationState();
  }
}

class ConversationState extends State<Conversation> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversation"),
        actions: [
          IconButton(
              onPressed: () {
                FirestoreHelper().deconnexion();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const MyHomePage(title: "");
                }));
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ))
        ],
      ),
      body: bodyPage(),
      
    );
  }

  Widget bodyPage() {

    return Container(
      child: Column(children: [
        ZoneText(widget.partner, Myprofil),
        Expanded(child: Messagecontroller(Myprofil, widget.partner)),
      ],)
    );
  }
}
