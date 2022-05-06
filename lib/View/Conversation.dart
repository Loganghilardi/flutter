import 'package:firstapplicationeisi/Fonctions/FirestoreHelper.dart';
import 'package:firstapplicationeisi/View/AllUsers.dart';
import 'package:firstapplicationeisi/View/MyUsers.dart';
import 'package:firstapplicationeisi/main.dart';
import 'package:flutter/material.dart';

class Conversation extends StatefulWidget {
      const Conversation({Key? key}) : super(key: key);

  @override
  State<Conversation> createState() => ConversationState();
}

class ConversationState extends State<Conversation> {

  int selected = 0;
  PageController controller = PageController(initialPage: 0);
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selected,
        onTap: (newValue) {
          setState(() {
            selected = newValue;
            controller.jumpToPage(newValue);
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "Utilisateurs"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "Paramètres")
        ],
      ),
    );
  }

  Widget bodyPage() {
    return Column(children: [
      //NOm et prénom
      Row(children: [Container(child: Text('Nom'))])
    ]);
  }
}
