import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_doctor/tab/past_appointment.dart';
import 'package:practo_doctor/tab/upcomming_appointment.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _AppointmentState extends State<Appointment>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Doctor Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<Object>(
          stream: FirebaseFirestore.instance
              .collection("doctorsprofile")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            var ds = snapshot.data;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Full Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    ds['doctorName'],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Select Age Range",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    ds['doctorDOB'],
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ),
                Divider(),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Specialization:",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ds['doctorSpecialization'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),

                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "About Doctor",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ds['doctorDesc'],
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
                Divider(),

                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Certificates",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
                Container(
                  height: 210,
                  padding: EdgeInsets.all(4),
                  child: GridView.builder(
                      itemCount: ds['doctorCertificationImages'].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (context, index) {
                        return Container(
                          height: 210,
                          margin: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      ds['doctorCertificationImages'][index]),
                                  fit: BoxFit.cover)),
                        );
                      }),
                ),

                // Spacer(),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Center(
                //     child: Container(
                //       margin: EdgeInsets.only(bottom: 20),
                //       child: ElevatedButton(
                //           onPressed: () {
                //             // Navigator.push(context,
                //             //     MaterialPageRoute(builder: (builder) => Payment()));
                //           },
                //           child: Text('Save'),
                //           style: ElevatedButton.styleFrom(
                //               shape: StadiumBorder(),
                //               primary: Color(0xfff0092E1),
                //               fixedSize: Size(330, 50))),
                //     ),
                //   ),
                // ),
              ],
            );
          }),
    );
  }
}
