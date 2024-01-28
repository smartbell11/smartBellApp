
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/controller/home_controller.dart';

import 'package:smart_school_bill/widgets/custom_toast.dart';

class ScheduleController extends GetxController {
FirebaseAuth auth = FirebaseAuth.instance;

HomeController homeController = HomeController();
   late SharedPreferences _prefs;
   String? uId;
void onInit() async {
  super.onInit();
  _prefs = await SharedPreferences.getInstance();
     uId = _prefs.getString('uId') ?? '';
}


    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextEditingController classNameC = TextEditingController();
    TextEditingController durationC = TextEditingController();
 

 Rx<DateTime> selectedTime = DateTime.now().obs;

  void updateSelectedTime(DateTime newTime) {
    selectedTime.value = newTime;
  }


String formattedTime = "";
  String formatTimeWithAMPM(DateTime dateTime) {
    TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = timeOfDay.hourOfPeriod;
    String formattedHour = hour == 0 ? '12' : hour.toString().padLeft(2, '0');
     formattedTime = '$formattedHour:${timeOfDay.minute.toString().padLeft(2, '0')} $period';
    return formattedTime;
  }




void addSchedule(BuildContext context) async {
  try {
    if (classNameC.text.isEmpty ||
        durationC.text.isEmpty ||
        formattedTime.isEmpty) {
      CustomToast.errorToast('Please complete all the fields');
    } else {
String docId = classNameC.text +formattedTime;
      DocumentReference schedule = firestore.collection("schedule").doc(docId);

      await schedule.set({
        "className": classNameC.text,
        "duration": durationC.text,
        "selectedStartTime": formattedTime,
        'isStopped': false,
        'docId':docId,
        'uId':uId
      });

      CustomToast.successToast("Added Successfully");
      classNameC.clear();
      durationC.clear();
    
    }
  } catch (error) {
    print("Error: $error");
  }
}



void editSchedule(BuildContext context, String documentId) async {
  try {
    if (classNameC.text.isEmpty ||
        durationC.text.isEmpty ||
        formattedTime.isEmpty
       ) 
        {
  CustomToast.errorToast('Please complete all the fields');
    }else {

      DocumentReference schedule = firestore.collection("schedule").doc(documentId);
      await schedule.update({
       "className": classNameC.text,
      "duration": durationC.text,
      "selectedStartTime":  formattedTime,
      });

      CustomToast.successToast("Edited Successfully");
      classNameC.clear();
      durationC.clear();
    }
  } catch (error) {
    print("Error: $error");
   
  }
}



void delete(id) async {
  try {
       await FirebaseFirestore.instance.collection("schedule").doc(id).delete();

    CustomToast.successToast("Successfully deleted");
  } catch (e) {
    print('Error deleting record: $e');
  }
}
}