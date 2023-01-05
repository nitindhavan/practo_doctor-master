import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final doctorid;
  final userid;
  final name;

  ChatPage({Key? key, this.doctorid, this.userid, this.name})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AllChats(
        doctorid: doctorid,
        name: name,
        userid: userid,
      ),
    );
  }
}
