import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_doctor/appointments/appointments_tabs.dart';
import 'package:practo_doctor/notification/notifications.dart';
import 'package:practo_doctor/schdule/schedule.dart';
import 'package:practo_doctor/view_detail/view_detail.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "asset/Vector.png",
              width: 34,
              height: 34,
            ),
          ),
          title: Text(
            'Practo',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Schdule()));
                },
                child: Text("Schedule")),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (builder) => Notifications()));
                },
                child: Text("Notifications")),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    autofocus: false,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: 'Search',
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.only(
                          left: 14.0, bottom: 6.0, top: 8.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Upcoming Appointments",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        AppointmentsTabssTabs()));
                          },
                          child: Text("See All"))
                    ],
                  ),
                ),
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('doctor_appointment')
                            .doc("details")
                            .collection("records")
                            .where(
                              "doctorid",
                              isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                            )
                            .where('status', isEqualTo: "start")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('No UpComming Appointment'),
                            );
                          }
                          if (snapshot.hasData) {
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
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        final DocumentSnapshot
                                            documentSnapshot =
                                            snapshot.data!.docs[index];
                                        return Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
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
                                              title: Text(
                                                  documentSnapshot['name']),
                                              subtitle: Text(
                                                  documentSnapshot['problem']),
                                            ),
                                            Divider()
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(),
                            );
                          }
                        })),
              ],
            ),
          ),
        ));
  }
}
