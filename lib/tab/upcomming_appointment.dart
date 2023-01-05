import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UpComing extends StatefulWidget {
  const UpComing({Key? key}) : super(key: key);

  @override
  State<UpComing> createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {
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
                    .where(
                      'status',
                      isEqualTo: 'start',
                    )
                    .where('doctorid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  print("Fawad");
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No UpComming Appointment'),
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
                                final DocumentSnapshot documentSnapshot =
                                    snapshot.data!.docs[index];

                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(documentSnapshot['name']),
                                      subtitle:
                                          Text(documentSnapshot['problem']),
                                      trailing: TextButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('appointments')
                                                .doc("details")
                                                .collection("records")
                                                .doc(documentSnapshot.id)
                                                .update({"status": "complete"});
                                          },
                                          child: Text("Complete")),
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
