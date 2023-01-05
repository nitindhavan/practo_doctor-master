import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_doctor/bottompages/chats/screens/chat_page.dart';
import 'package:practo_doctor/view_detail/view_detail.dart';
import 'package:uuid/uuid.dart';

class StatusAppointment extends StatefulWidget {
  StatusAppointment({
    super.key,
  });

  @override
  State<StatusAppointment> createState() => _StatusAppointmentState();
}

class _StatusAppointmentState extends State<StatusAppointment> {
  var doctorID;
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
                      isEqualTo: 'pending',
                    )
                    .where('doctorid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(includeMetadataChanges: true),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  print("Fawad");
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text('No Data Found'),
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
                                        trailing: Column(
                                          children: [
                                            Expanded(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (builder) =>
                                                                    View_Detial(
                                                                      age: documentSnapshot[
                                                                          'age'],
                                                                      id: documentSnapshot[
                                                                          'id'],
                                                                      date: documentSnapshot[
                                                                          'date'],
                                                                      name: documentSnapshot[
                                                                          'name'],
                                                                      problem:
                                                                          documentSnapshot[
                                                                              'problem'],
                                                                    )));
                                                  },
                                                  child: Text("View")),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                onPressed: () async {
                                                  print(documentSnapshot);
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                          'doctor_appointment')
                                                      .doc("details")
                                                      .collection("records")
                                                      .doc(documentSnapshot.id)
                                                      .update({
                                                    "status": "start"
                                                  }).whenComplete(() {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (builder) =>
                                                                    ChatPage(
                                                                      doctorid:
                                                                          documentSnapshot[
                                                                              'doctorid'],
                                                                      userid: documentSnapshot[
                                                                          'id'],
                                                                      name: documentSnapshot[
                                                                          'name'],
                                                                    )));
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
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
// complete
// pending
// start
  // //Update Functions

}
