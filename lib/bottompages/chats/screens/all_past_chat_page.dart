import 'package:practo_doctor/bottompages/chats/screens/all_chat_past.dart';

import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class AllPastChatPage extends StatelessWidget {
  final doctorid;
  final userid;
  final name;

  AllPastChatPage({Key? key, this.doctorid, this.userid, this.name})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: AllChatsPast(
        doctorid: doctorid,
        name: name,
        userid: userid,
      ),
    );
  }
}
