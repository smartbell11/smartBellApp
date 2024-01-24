
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

    FirebaseFirestore firestore = FirebaseFirestore.instance;

   late SharedPreferences _prefs;
var schoolName = "".obs;
var phone = "".obs;
var email = "".obs;
@override
void onInit() async {
  super.onInit();
fetchScheduleCount();
startLoop() ;

  _prefs = await SharedPreferences.getInstance();
     schoolName.value = _prefs.getString('schoolName') ?? '';
         email.value = _prefs.getString('email') ?? '';
}
  RxInt scheduleCount = 0.obs; 


  Future<void> fetchScheduleCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('schedule')
          .get();
      scheduleCount.value = snapshot.size ?? 0;
    } catch (error) {
      print('Error fetching schedule count: $error');
    }
  }
  String getScheduleCountText() {
    return 'You have ${scheduleCount > 3 ? '3+' : scheduleCount} schedules';
  }
  

 String formatTimeWithAMPM(DateTime dateTime) {
  TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
  String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'; 
  int hour = timeOfDay.hourOfPeriod;
  String formattedHour = hour == 0 ? '12' : hour.toString().padLeft(2, '0');
  return '$formattedHour:${timeOfDay.minute.toString().padLeft(2, '0')} $period';
}



void startLoop() async {

  DateTime now = DateTime.now();
  
  String deviceTime = formatTimeWithAMPM(now);

  QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
      await firestore.collection("schedule").get();

  List<String> selectedStartTimes = scheduleSnapshot.docs
      .map<String>((doc) => doc['selectedStartTime'] as String)
      .toList();


  if (selectedStartTimes.contains(deviceTime)) {
    if (now.weekday != DateTime.friday && now.weekday != DateTime.saturday) {

      await checkAndUpdateFirebase(deviceTime);

      print('Time matched: $deviceTime');
    } else {
      print('Today is Friday or Saturday. Firebase value not changed.');
    }
  }
}





Future<void> checkAndUpdateFirebase(String deviceTime) async {
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('bell');

  QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
      await firestore.collection("schedule").where("selectedStartTime", isEqualTo: deviceTime).get();

  bool isStopped = false;
  int durationInSeconds = 0;

  if (scheduleSnapshot.docs.isNotEmpty) {
    isStopped = scheduleSnapshot.docs.first['isStopped']; 

    durationInSeconds = int.parse(scheduleSnapshot.docs.first['duration']); 
  }

  if (isStopped) {
    print('The specified time $deviceTime is stopped. Firebase value not changed.');
  } else {
    reference.update({'ring': 1});
    changeTime(deviceTime) ;
    print('Updated Firebase ring value to 1.');


    await Future.delayed(Duration(seconds: durationInSeconds)); 
    reference.update({'ring': 0});
    print('Reset Firebase ring value to 0 after $durationInSeconds seconds.');
  }
}



Future<void> changeTime(String deviceTime) async {
   FirebaseDatabase.instance
          .reference()
          .child("bell")
          .update({"Time": deviceTime});
}


}

