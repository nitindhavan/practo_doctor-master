import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_doctor/database/storage_methods.dart';
import 'package:practo_doctor/models/profile_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:practo_doctor/models/schdule_model.dart';

import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//Add Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//OTP Number Add
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      ProfileModel userModel = ProfileModel(
          like: false,
          doctorAddres: '',
          doctorCertificationImages: [],
          doctorDOB: '',
          doctorDesc: '',
          doctorEmail: '',
          doctorHospital: '',
          doctorName: '',
          doctorPhotoURL: '',
          doctorSpecialization: '',
          doctortreatedDiseacs: '',
          uid: '',
          experience: '',
          phoneNumber: '');
      await firebaseFirestore
          .collection('doctorsprofile')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail({
    required doctorAddres,
    required doctorDOB,
    required doctorDesc,
    required doctorEmail,
    required doctorHospital,
    required doctorName,
    required doctorSpecialization,
    required doctortreatedDiseacs,
    required uid,
    required Uint8List file,
    required experience,
  }) async {
    String res = 'Some error occured';

    try {
      if (doctorEmail.isNotEmpty || doctorHospital.isNotEmpty || doctorDOB) {
        String photoURL = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        //Add User to the database with modal

        ProfileModel userModel = ProfileModel(
            like: false,
            doctorCertificationImages: [],
            uid: uid,
            experience: experience,
            doctorAddres: doctorAddres,
            doctorDOB: doctorDOB,
            doctorDesc: doctorDesc,
            doctorEmail: doctorEmail,
            doctorHospital: doctorHospital,
            doctorName: doctorName,
            doctorPhotoURL: photoURL,
            doctorSpecialization: doctorSpecialization,
            doctortreatedDiseacs: doctortreatedDiseacs,
            phoneNumber:
                FirebaseAuth.instance.currentUser!.phoneNumber.toString());
        await firebaseFirestore
            .collection('doctorsprofile')
            .doc(uid)
            .update(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> profileUpdate({
    required doctorAddres,
    required doctorDesc,
    required doctorEmail,
    required doctorHospital,
    required doctorSpecialization,
    required doctortreatedDiseacs,
    required experience,
  }) async {
    String res =
        'Update all the fields data to store it because doctor information will be updated in sequences ';

    try {
      if (doctorEmail.isNotEmpty || doctorHospital.isNotEmpty) {
        //Add User to the database with modal

        await firebaseFirestore
            .collection('doctorsprofile')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "doctorAddres": doctorAddres,
          "doctorDesc": doctorDesc,
          "doctorEmail": doctorEmail,
          "doctorHospital": doctorHospital,
          "doctorSpecialization": doctorSpecialization,
          "doctortreatedDiseacs": doctortreatedDiseacs,
          "experience": experience
        });
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

//   Future<String> doctorTime({
//     required String time,
//     required String day,
//     required String uid,
//     required uuid,
//   }) async {

//     ;
//     try {
//       if (time.isNotEmpty || day.isNotEmpty) {
//         // String servicId = Uuid().v1();

//         SchduleModel serviceModel = SchduleModel(
//           time: time,
//           day: day,
//           uid: uid,
//           uuid: uuid,
//         );

//             );
//         res = 'Success';
//       }
//     } catch (error) {
//       res = error.toString();
//     }
//     return res;
//   }
// }
//Add Service
  Future<String> doctorTime(
      {required String time, required String day, required String uid, required String endtime}) async {
    String res =
        'Update all the fields data to store it because doctor information will be updated in sequences ';
    try {
      if (time.isNotEmpty || day.isNotEmpty) {
        String uuid = Uuid().v1();

        SchduleModel serviceModel = SchduleModel(
          time: time,
          day: day,
          uid: uid,
          uuid: uuid,
          endtime: endtime
        );

        firebaseFirestore
            .collection('doctorTime')
            .doc("doctorname")
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .doc(uuid)
            .set(
              serviceModel.toJson(),
            );
        res = 'Success';
      }
    } catch (error) {
      res = error.toString();
    }
    return res;
  }
}
