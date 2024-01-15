import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:smart_school_bill/style/images.dart';
import 'package:smart_school_bill/widgets/custom_dialog.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class ScheduleController extends GetxController {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextEditingController classNameC = TextEditingController();
    TextEditingController durationC = TextEditingController();
 String formattedStartDate = "";
Rx<DateTime> selectedDate = DateTime.now().obs;

  void updateSelectedDate(DateTime newDate) {
    selectedDate.value = newDate;
  }

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
        durationC.text.isEmpty
       ) 
        {
  CustomToast.errorToast('Please complete all the fields');
    }
    
else{
   formattedStartDate = DateFormat('d-MM-yyyy').format(selectedDate.value);

    DocumentReference schedule = firestore.collection("schedule").doc();
    await schedule.set({
      "className": classNameC.text,
      "duration": durationC.text,
      "selectedStartTime":  formattedTime,
      "selectedStartDate": formattedStartDate,
      "createdAt": DateTime.now().toIso8601String(),
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
        durationC.text.isEmpty
       ) 
        {
  CustomToast.errorToast('Please complete all the fields');
    }else {
      String formattedStartDate = DateFormat('d-MM-yyyy').format(selectedDate.value);

      DocumentReference schedule = firestore.collection("schedule").doc(documentId);
      await schedule.update({
       "className": classNameC.text,
      "duration": durationC.text,
      "selectedStartTime":  formattedTime,
      "selectedStartDate": formattedStartDate,
      });

      CustomToast.successToast("Edited Successfully");
      classNameC.clear();
      durationC.clear();
    }
  } catch (error) {
    print("Error: $error");
    // Handle the error as needed
  }
}


Future<void> showSuccessDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final dialog = const RoundedDialog2(
        title: 'Added Successfully',
        message: '',
        imagePath: Images.Success,
      );  
     return dialog;
    },
  );
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