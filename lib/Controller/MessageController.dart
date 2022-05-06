import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firstapplicationeisi/model/Utilisateur.dart';

import '../model/MyProfil.dart';

class Messagecontroller extends StatefulWidget{
  MyProfil id;
  Utilisateur idPartner;
  Messagecontroller(@required MyProfil this.id,@required Utilisateur this.idPartner);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MessagecontrollerState();
  }

}
 class MessagecontrollerState extends State<Messagecontroller> {
 late Animation animation;
 late AnimationController controller;
 @override
 void dispose() {
 controller.dispose();
 super.dispose();
 }
 @override
 Widget build(BuildContext context) {

 return StreamBuilder<QuerySnapshot>(
  stream: firestoreHelper().fire_message.orderBy('envoiMessage',descending:
true).snapshots(),
 builder: (BuildContext context, AsyncSnapshot <QuerySnapshot>snapshot)
{
 if (!snapshot.hasData) {
 return const CircularProgressIndicator();
 }
 else {
 List<DocumentSnapshot>documents = snapshot.data!.docs;
 return ListView.builder(
 itemCount: documents.length,
 itemBuilder: (BuildContext ctx,int index)
 {
 Message discussion = Message(documents[index]);
 if((discussion.from==widget.id.id &&
discussion.to==widget.idPartner.id)||
(discussion.from==widget.idPartner.id&&discussion.to==widget.id.id))
 {
 return messageBubble(widget.id.id, widget.idPartner, discussion,);
 }
 else
 {
 return Container();
 }
 }
 );
 }
 }
 );
 }

  firestoreHelper() {}
}

class messageBubble extends StatelessWidget{
 Message message;
 Utilisateur partenaire;
 String monId;
 Animation? animation;
 messageBubble(@required String this.monId,@required Utilisateur
this.partenaire,@required Message this.message,{Animation? this.animation});
 @override
 Widget build(BuildContext context) {
 // TODO: implement build
 return Container(
 margin: EdgeInsets.all(10),
 child: Row(
 children: widgetBubble(message.from==monId),
 ),
 );
 }
 List< Widget> widgetBubble(bool moi){
 CrossAxisAlignment alignment = (moi)?
CrossAxisAlignment.end:CrossAxisAlignment.start;
 Color colorBubble =(moi)? Colors.green: Colors.blue;
 Color textcolor =Colors.white;
 return <Widget>[
 Expanded(
 child: Column(
 crossAxisAlignment: alignment,
 children: [
 Card(
 elevation: 5.0,
 shape: RoundedRectangleBorder(borderRadius:
BorderRadius.circular(10)),
 color: colorBubble,
 child: Container(

 padding: EdgeInsets.all(animation?.value),
 child: Text(message.texte,style: TextStyle(color: textcolor),),
 ),
 ),
 ],
 ),
 )
 ];
 }
}
class ZoneText extends StatefulWidget{
 Utilisateur partenaire;
 MyProfil moi;
 ZoneText(@required Uitlisateur this.partenaire,@required MyProfil this.moi);
 @override
 State<StatefulWidget> createState() {
 // TODO: implement createState
 return ZoneTextState();
 }
}
TextEditingController _textEditingController =new TextEditingController();
class ZoneTextState extends State<ZoneText>{
 @override
 Widget build(BuildContext context) {
 // TODO: implement build
 return Container(
 color: Colors.grey[300],
 padding: EdgeInsets.all(15),
 child: Row(
 children: [
 Flexible(
 child: TextField(
 controller: _textEditingController,
 decoration: InputDecoration.collapsed(
 hintText: "écrivez votre message",),
 maxLines: null,
 ),
 ),
 IconButton(icon: Icon(Icons.send), onPressed: _sendBouttonpressed)
 ],
 ),
 );
 }
 _sendBouttonpressed(){
 if(_textEditingController!=null && _textEditingController!=""){
 String text=_textEditingController.text;
 print('enregistrement');
 firestoreHelper().sendMessage(text, widget.partenaire,widget.moi);
 setState(() {
 _textEditingController.text='';
 });
 FocusScope.of(context).requestFocus(new FocusNode());
 _sendMessage();
 }
 }
 _sendMessage(){
 //envoie message dans firebase
 print(_textEditingController.text);
 }

  firestoreHelper() {}
}