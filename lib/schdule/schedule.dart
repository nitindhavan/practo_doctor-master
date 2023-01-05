import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_doctor/schdule/add_schdule.dart';
import 'package:uuid/uuid.dart';

class Schdule extends StatefulWidget {
  const Schdule({Key? key}) : super(key: key);

  @override
  State<Schdule> createState() => _SchduleState();
}

class _SchduleState extends State<Schdule> {
  var id = Uuid().v1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Date And Time"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.schedule,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (builder) => AddSchdule()));
          }),
      body: Container(
        height: 500,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("doctorTime")
              .doc("doctorname")
              .collection(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return ListTile(
                  title: Text(data['time']),
                  subtitle: Text(data['day']),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      print("Bt");
                      FirebaseFirestore.instance
                          .collection("doctorTime")
                          .doc("doctorname")
                          .collection(FirebaseAuth.instance.currentUser!.uid)
                          .doc(data["uuid"])
                          .delete();
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),

      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       StreamBuilder(
      // stream: FirebaseFirestore.instance
      //     .collection("doctorTime")
      //     .doc("doctorname")
      //     .collection(FirebaseAuth.instance.currentUser!.uid)
      //     .snapshots(),
      //         builder: (context, AsyncSnapshot snapshot) {
      //           if (!snapshot.hasData) {
      //             return new CircularProgressIndicator();
      //           }
      //           var document = snapshot.data;

      //           return SizedBox(
      //             height: MediaQuery.of(context).size.height,
      //             child: ListView.builder(
      //                 itemCount: snapshot.data!.docs.length,
      //                 itemBuilder: (context, index) {
      //                   return ListTile(
      //                     title: Text(document['time']),
      //                     subtitle: Text(document['day']),
      //                   );
      //                 }),
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
    );
  }
}
