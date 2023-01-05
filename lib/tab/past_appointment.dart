import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uuid/uuid.dart';

class Past extends StatefulWidget {
  const Past({Key? key}) : super(key: key);

  @override
  State<Past> createState() => _PastState();
}

class _PastState extends State<Past> {
  var id = Uuid().v1();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FirebaseAuth.instance.currentUser != null
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('doctor_appointment')
                    .doc("details")
                    .collection("records")
                    .where('doctorid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .where("status", isEqualTo: "complete")
                    .snapshots(),
                builder: (context, AsyncSnapshot snapshot) {
                  print("Fawad");
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No Complete Appointment'),
                    );
                  }
                  if (snapshot.hasData) {
                    print("working");
                    return Column(
                      children: [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(
                        //     '29 Decemeber 2002',
                        //     textAlign: TextAlign.start,
                        //     style:
                        //         TextStyle(color: Colors.black, fontWeight: FontWeight.w900),
                        //   ),
                        // ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                Map<String, dynamic> snap =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                return Column(
                                  children: [
                                    ListTile(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (builder) =>
                                        //         AppointCurrentDetail(),
                                        //   ),
                                        // );
                                      },
                                      title: Text(snap['name']),
                                      subtitle: Text(snap['problem']),
                                    ),
                                    Divider()
                                  ],
                                );
                              }),
                        ),
                      ],
                    );
                  } else {
                    print("Not Working");
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                })
            : const Center(
                child: Text('No Appointment Approval is needed'),
              ),
      ),
    );
  }
}
