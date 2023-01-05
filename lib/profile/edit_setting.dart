import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_doctor/bottom.dart';
import 'package:practo_doctor/database/databasemethods.dart';
import 'package:practo_doctor/profile/doctor_certificates.dart';
import 'package:practo_doctor/widgets/textfieldwidget.dart';
import 'package:practo_doctor/widgets/utils.dart';

class Edit_Setting extends StatefulWidget {
  const Edit_Setting({Key? key}) : super(key: key);

  @override
  _Edit_SettingState createState() => _Edit_SettingState();
}

class _Edit_SettingState extends State<Edit_Setting> {
  final TextEditingController doctornameController = TextEditingController();
  final TextEditingController doctoremailController = TextEditingController();
  final TextEditingController doctorAddressController = TextEditingController();
  final TextEditingController doctorHospitalNameController =
      TextEditingController();
  final TextEditingController doctorDateofBirthContorller =
      TextEditingController();
  final TextEditingController doctorExperienceController =
      TextEditingController();
  final TextEditingController doctorDiseaseController = TextEditingController();

  final TextEditingController doctorDescriptionController =
      TextEditingController();
  final TextEditingController doctorSpecializationCOntroller =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    doctornameController.clear();
    doctoremailController.clear();
    doctorAddressController.clear();
    doctorHospitalNameController.clear();
    doctorDateofBirthContorller.clear();
    doctorExperienceController.clear();
    doctorDiseaseController.clear();

    doctorDescriptionController.clear();
    doctorSpecializationCOntroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Edit Doctor Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("doctorsprofile")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new CircularProgressIndicator();
                }
                var document = snapshot.data;
                doctoremailController.text = document['doctorEmail'];
                doctorAddressController.text = document['doctorAddres'];

                doctorHospitalNameController.text = document['doctorHospital'];
                doctorExperienceController.text = document['experience'];
                doctorDateofBirthContorller.text = document['doctorDOB'];
                doctorSpecializationCOntroller.text =
                    document['doctorSpecialization'];
                doctorDiseaseController.text = document['doctortreatedDiseacs'];
                doctorDescriptionController.text = document['doctorDesc'];
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage:
                              NetworkImage(document['doctorPhotoURL']),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          document['doctorName'],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email),
                          fillColor: Colors.white,
                          hintText: 'Email',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: doctoremailController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.local_hospital),
                          fillColor: Colors.white,
                          hintText: 'Hospital Name',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: doctorHospitalNameController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.type_specimen),
                          fillColor: Colors.white,
                          hintText: 'Specialization',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: doctorSpecializationCOntroller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.disabled_by_default),
                          fillColor: Colors.white,
                          hintText: 'Disease',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: doctorDiseaseController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.description),
                          fillColor: Colors.white,
                          hintText: 'Description',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: doctorDescriptionController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.home),
                          fillColor: Colors.white,
                          hintText: 'Address',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: doctorAddressController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.explore),
                          fillColor: Colors.white,
                          hintText: 'Experience',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: doctorExperienceController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.width / 3,
                        child: Text(document['doctorDOB'] //label text of field
                            ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfff0092E1).withOpacity(.6),
                            fixedSize: const Size(350, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: profileUpdates,
                          child: _isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(
                                  'Update',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal),
                                ),
                        ),
                      ),
                    ]);
              }),
        ));
  }

  profileUpdates() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await DatabaseMethods().profileUpdate(
      doctortreatedDiseacs: doctorDiseaseController.text,
      doctorDesc: doctorDescriptionController.text,
      experience: doctorExperienceController.text,
      doctorEmail: doctoremailController.text,
      doctorAddres: doctorAddressController.text,
      doctorSpecialization: doctorSpecializationCOntroller.text,
      doctorHospital: doctorHospitalNameController.text,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'success') {
      showSnakBar(rse, context);
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => MobileScreenLayout()));
    } else {
      showSnakBar(rse, context);
    }
  }
}
