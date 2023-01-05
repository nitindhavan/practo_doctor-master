// import 'package:college_meet/BottomNavigatonBar/Screens/Edit%20Setting/edit_Setting.dart'
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:practo_doctor/auth/continuephone.dart';
import 'package:practo_doctor/auth/mainauth.dart';
import 'package:practo_doctor/notification/notifications.dart';
import 'package:practo_doctor/profile/edit_setting.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Practo Doctpr',
        text: 'Hey: Its New App For Doctors',
        linkUrl: 'https://play.google.com/store/apps/details',
        chooserTitle: 'Hey: Its New App For Doctors');
  }

  zisttile(String text, IconData icon, VoidCallback function) {
    return ListTile(
        onTap: function,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              color: Color(0xffE4ECFE),
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              )),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              icon,
              color: Color(0xff1060D7),
            ),
          ),
        ),
        title: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ),
        trailing: IconButton(
          onPressed: function,
          icon: Icon(
            Icons.arrow_forward_ios,
            color: Colors.blue,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Container(
            margin: EdgeInsets.all(8),
            // padding: EdgeInsets.all(20),
            // margin: EdgeInsets.all(left: 10),
            width: 45,
            height: 45,

            child: Image.asset("asset/Vector.png"),
          ),
          title: Text(
            'Setting',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 10),
                  width: 50,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Color(0xffE4ECFE),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Color(0xff1060D7)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => Edit_Setting()));
                    },
                  )),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("doctorsprofile")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return new CircularProgressIndicator();
                    }
                    var document = snapshot.data;
                    return Column(
                      children: [
                        Center(
                          child: Container(
                            height: 110,
                            // width: MediaQuery.of(context).size.width * 0.9,
                            // width: 100,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 55,
                                  backgroundImage:
                                      NetworkImage(document['doctorPhotoURL']),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          document['doctorName'],
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 22),
                        ),
                      ],
                    );
                  }),

              SizedBox(
                height: 20,
              ),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
              ),
              // ListTile()
              zisttile('Edit Setting', Icons.person, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Edit_Setting()));
              }),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
              ),
              zisttile('Notification', Icons.notifications, () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Notifications()));
              }),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
              ),
              zisttile('Security', Icons.lock, () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (builder) => Invite_Friends()));
              }),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
              ),

              zisttile('Invite Friends', Icons.people, share),
              Divider(
                color: Colors.grey,
                thickness: 0.5,
                indent: 15,
                endIndent: 15,
              ),
              // zisttile('Logout', Icons.login_outlined, () async {
              //   await FirebaseAuth.instance.signOut().then((value) => {
              //         Navigator.pushReplacement(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (builder) => MainAuth()))
              //       });
              // })
            ],
          ),
        ));
  }
}
