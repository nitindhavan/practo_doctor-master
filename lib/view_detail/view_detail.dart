import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class View_Detial extends StatefulWidget {
  String? id;
  final problem;
  final name;
  final date;
  final age;
  View_Detial(
      {super.key,
      required this.date,
      required this.id,
      required this.name,
      required this.problem,
      required this.age});

  @override
  State<View_Detial> createState() => _View_DetialState();
}

class _View_DetialState extends State<View_Detial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          widget.name,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("doctorsprofile")
              .doc(widget.id)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            var snap = snapshot.data;

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      "asset/splash.png",
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Paitent Age:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.age,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Divider(),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Paitent Problem",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      widget.problem,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Text(
                  //     "View Records",
                  //     style: TextStyle(
                  //         color: Colors.black,
                  //         fontWeight: FontWeight.w700,
                  //         fontSize: 20),
                  //   ),
                  // ),
                  // // StreamBuilder(
                  // //     stream: FirebaseFirestore.instance
                  // //         .collection("medicalRecords")
                  // //         .doc(widget.id)
                  // //         .collection("records")
                  // //         .snapshots(),
                  // //     builder: (context, AsyncSnapshot snapshot) {
                  // //       var snap = snapshot.data;
                  // //       return Container(
                  // //         height: 210,
                  // //         padding: EdgeInsets.all(4),
                  // //         child: GridView.builder(
                  // //             itemCount: snapshot.data!.docs.length,
                  // //             gridDelegate:
                  // //                 SliverGridDelegateWithFixedCrossAxisCount(
                  // //                     crossAxisCount: 3),
                  // //             itemBuilder: (context, index) {
                  // //               final DocumentSnapshot documentSnapshot =
                  // //                   snapshot.data!.docs[index];
                  // //               return Container(
                  // //                 height: 210,
                  // //                 margin: EdgeInsets.all(3),
                  // //                 decoration: BoxDecoration(
                  // //                     borderRadius: BorderRadius.circular(20),
                  // //                     image: DecorationImage(
                  // //                         image: NetworkImage(
                  // //                             documentSnapshot['images']
                  // //                                 [index]),
                  // //                         fit: BoxFit.cover)),
                  // //               );
                  // //             }),
                  // //       );
                  // //     }),
                ]);
          }),
    );
  }
}
