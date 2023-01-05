import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_doctor/database/databasemethods.dart';
import 'package:practo_doctor/profile/doctor_certificates.dart';
import 'package:practo_doctor/widgets/textfieldwidget.dart';
import 'package:practo_doctor/widgets/utils.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String imageLink = "";
  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Image.asset("asset/Vector.png"),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () => selectImage(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 374,
                      height: 157,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xffD2D2D2),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _image != null
                              ? CircleAvatar(
                                  radius: 59,
                                  backgroundImage: MemoryImage(_image!))
                              : Image.asset(
                                  "asset/cam.png",
                                  width: 51,
                                  height: 39,
                                ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: RichText(
                              text: TextSpan(
                                text: 'Upload photo profile',
                                style: GoogleFonts.getFont(
                                  'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontStyle: FontStyle.normal,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '*',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.red,
                                        fontStyle: FontStyle.normal,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter UserName ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter your username',
                  textInputType: TextInputType.text,
                  controller: doctornameController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Email ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  controller: doctoremailController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Hospital Name ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter your hospital name',
                  textInputType: TextInputType.text,
                  controller: doctorHospitalNameController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Specialization',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter your specialization',
                  textInputType: TextInputType.text,
                  controller: doctorSpecializationCOntroller,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Disease Specialized ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter List of disease user treated',
                  textInputType: TextInputType.text,
                  controller: doctorDiseaseController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Description',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Doctor Description',
                  textInputType: TextInputType.text,
                  controller: doctorDescriptionController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Address ',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter Doctor Address',
                  textInputType: TextInputType.text,
                  controller: doctorAddressController,
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: RichText(
                    text: TextSpan(
                      text: 'Enter Experience',
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: '*',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                              fontSize: 12,
                              fontStyle: FontStyle.normal,
                            )),
                      ],
                    ),
                  ),
                ),
                TextFormInputField(
                  hintText: 'Enter Doctor Experience',
                  textInputType: TextInputType.number,
                  controller: doctorExperienceController,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    padding: EdgeInsets.all(15),
                    height: MediaQuery.of(context).size.width / 3,
                    child: Center(
                        child: TextField(
                      controller: doctorDateofBirthContorller,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          icon: Icon(Icons.calendar_today), //icon of text field
                          labelText: "Enter Date" //label text of field
                          ),
                      readOnly: true,
                      //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1950),
                            //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2100));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          setState(() {
                            doctorDateofBirthContorller.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {}
                      },
                    ))),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xfff0092E1).withOpacity(.6),
                      fixedSize: const Size(350, 60),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    onPressed: profile,
                    child: _isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Text(
                            'Confrim',
                            style: GoogleFonts.getFont('Montserrat',
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 15,
                                fontStyle: FontStyle.normal),
                          ),
                  ),
                ),
              ]),
        ));
  }

  // Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  profile() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await DatabaseMethods().profileDetail(
      doctortreatedDiseacs: doctorDiseaseController.text,
      doctorDesc: doctorDescriptionController.text,
      doctorDOB: doctorDateofBirthContorller.text,
      experience: doctorExperienceController.text,
      doctorEmail: doctoremailController.text,
      doctorName: doctornameController.text,
      doctorAddres: doctorAddressController.text,
      file: _image!,
      doctorSpecialization: doctorSpecializationCOntroller.text,
      doctorHospital: doctorHospitalNameController.text,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'success') {
      showSnakBar(rse, context);
      Navigator.push(context,
          MaterialPageRoute(builder: (builder) => DoctorCertificates()));
    } else {
      showSnakBar(rse, context);
    }
  }
}
