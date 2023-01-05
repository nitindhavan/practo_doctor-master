import 'package:cloud_firestore/cloud_firestore.dart';

//Modal Need to Be Created in profile Page is
// Disear Name which he trated,
// experience,

class ProfileModel {
  String uid;
  String doctorAddres;
  String doctorEmail;
  String doctorDOB;
  String doctorName;
  String doctorDesc;
  String doctorHospital;
  String doctorSpecialization;
  String phoneNumber;
  String doctorPhotoURL;
  List<String>? doctorCertificationImages;
  String doctortreatedDiseacs;
  String experience;
  bool like;

  ProfileModel({
    required this.uid,
    required this.like,
    required this.doctorHospital,
    required this.doctorSpecialization,
    required this.doctorEmail,
    required this.doctorPhotoURL,
    required this.doctorAddres,
    required this.doctorName,
    required this.experience,
    required this.doctorCertificationImages,
    required this.doctorDOB,
    required this.doctorDesc,
    required this.doctortreatedDiseacs,
    required this.phoneNumber,
  });

  ///Converting OBject into Json Object
  Map<String, dynamic> toJson() => {
        'doctorName': doctorName,
        'experience': experience,
        'doctorDOB': doctorDOB,
        'doctorDesc': doctorDesc,
        'doctortreatedDiseacs': doctortreatedDiseacs,
        'doctorCertificationImages': doctorCertificationImages,
        'uid': uid,
        'doctorEmail': doctorEmail,
        'phoneNumber': phoneNumber,
        'doctorPhotoURL': doctorPhotoURL,
        'doctorSpecialization': doctorSpecialization,
        'doctorAddres': doctorAddres,
        'doctorHospital': doctorHospital,
        'like':like
      };

  ///
  static ProfileModel fromSnap(DocumentSnapshot snaps) {
    var snapshot = snaps.data() as Map<String, dynamic>;

    return ProfileModel(
      doctorName: snapshot['doctorName'],
      experience: snapshot['experience'],
      doctorDOB: snapshot['doctorDOB'],
      uid: snapshot['uid'],
      doctorDesc: snapshot['doctorDesc'],
      doctortreatedDiseacs: snapshot['doctortreatedDiseacs'],
      doctorCertificationImages: snapshot['doctorCertificationImages'],
      doctorEmail: snapshot['doctorEmail'],
      phoneNumber: snapshot['phoneNumber'],
      doctorPhotoURL: snapshot['doctorPhotoURL'],
      doctorSpecialization: snapshot['doctorSpecialization'],
      doctorAddres: snapshot['doctorAddres'],
      doctorHospital: snapshot['doctorHospital'],
      like:snapshot['like']
    );
  }
}
