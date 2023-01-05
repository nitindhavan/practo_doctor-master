import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practo_doctor/bottom.dart';
import 'package:practo_doctor/database/databasemethods.dart';
import 'package:practo_doctor/widgets/textfieldwidget.dart';
import 'package:practo_doctor/widgets/utils.dart';
import 'package:uuid/uuid.dart';

class AddSchdule extends StatefulWidget {
  const AddSchdule({Key? key}) : super(key: key);

  @override
  State<AddSchdule> createState() => _AddSchduleState();
}

class _AddSchduleState extends State<AddSchdule> {
  bool _isLoading = false;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController endtime = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Add Avaiable Date And Time"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: TextField(
                controller:
                    timeController, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText:
                        "Enter Appointment Start Time" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      timeController.text =
                          formattedTime; //set the value of text field.
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: TextField(
                controller: endtime, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.timer), //icon of text field
                    labelText:
                        "Enter Appointment End Time" //label text of field
                    ),
                readOnly:
                    true, //set it true, so that user will not able to edit text
                onTap: () async {
                  TimeOfDay? pickedTime = await showTimePicker(
                    initialTime: TimeOfDay.now(),
                    context: context,
                  );

                  if (pickedTime != null) {
                    print(pickedTime.format(context)); //output 10:51 PM
                    DateTime parsedTime = DateFormat.jm()
                        .parse(pickedTime.format(context).toString());
                    //converting to DateTime so that we can further format on different pattern.
                    print(parsedTime); //output 1970-01-01 22:53:00.000
                    String formattedTime =
                        DateFormat('HH:mm:ss').format(parsedTime);
                    print(formattedTime); //output 14:59:00
                    //DateFormat() is from intl package, you can format the time on any pattern you need.

                    setState(() {
                      endtime.text =
                          formattedTime; //set the value of text field.
                    });
                  } else {
                    print("Time is not selected");
                  }
                },
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Center(
              child: TextField(
                controller: dateController,
                //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "Select Date" //label text of field
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
                      dateController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {}
                },
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: add,
            child: _isLoading == true
                ? const Center(
                    child: CircularProgressIndicator.adaptive(),
                  )
                : Text("Add"),
            style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                fixedSize: Size(200, 50),
                textStyle:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  add() async {
    String ui = Uuid().v1();

    setState(() {
      _isLoading = true;
    });
    String rse = await DatabaseMethods().doctorTime(
      endtime: endtime.text,
      uid: FirebaseAuth.instance.currentUser!.uid,
      day: dateController.text,
      time: timeController.text,
      // uid: FirebaseAuth.instance.currentUser!.uid,
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
