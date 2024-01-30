
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  @override
void onInit() async {
  super.onInit();
await getLocalData();
await startLoop();
}
  FirebaseAuth auth = FirebaseAuth.instance;
   late SharedPreferences _prefs;
var schoolName = "".obs;
var phone = "".obs;
var email = "".obs;
var uId = "".obs;

Future getLocalData() async{
 _prefs = await SharedPreferences.getInstance();
     schoolName.value = _prefs.getString('schoolName') ?? '';
         email.value = _prefs.getString('email') ?? '';
       //   uId.value = _prefs.getString('uId') ?? '';
          update();
}



    FirebaseFirestore firestore = FirebaseFirestore.instance;


  RxInt scheduleCount = 0.obs; 



Future<int> getScheduleDocumentCount() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('schedule')
              .where('uId', isEqualTo: auth.currentUser!.uid)
              .get();
      return snapshot.size;
    } catch (error) {
      print('Error fetching schedule count: $error');
      return 0;
    }
  }

 

 String formatTimeWithAMPM(DateTime dateTime) {
  TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTime);
  String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'; 
  int hour = timeOfDay.hourOfPeriod;
  String formattedHour = hour == 0 ? '12' : hour.toString().padLeft(2, '0');
  return '$formattedHour:${timeOfDay.minute.toString().padLeft(2, '0')} $period';
}

RxBool shouldRing = true.obs;


Future startLoop() async {
  print("it is ${shouldRing.value}");
if(shouldRing.isTrue){
   DateTime now = DateTime.now();
  
  String deviceTime = formatTimeWithAMPM(now);

  QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
      await firestore.collection("schedule").where('uId', isEqualTo: uId.value).get();

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

}else{
  print("it will not do anything");
}
}


Future<void> checkAndUpdateFirebase(String deviceTime) async {
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('bell');

  QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
      await firestore.collection("schedule").where('uId', isEqualTo: uId.value).where("selectedStartTime", isEqualTo: deviceTime).get();

  bool isStopped = false;
  int durationInSeconds = 0;

  if (scheduleSnapshot.docs.isNotEmpty) {
    isStopped = scheduleSnapshot.docs.first['isStopped']; 

    durationInSeconds = int.parse(scheduleSnapshot.docs.first['duration']); 
  }

  if (isStopped) {
    print('The specified time $deviceTime is stopped. Firebase value not changed.');
  } else {
    shouldRing.value = false;

    reference.update({'Ring': 1});
        print("it is true ring ${shouldRing.value}");

    print('Updated Firebase ring value to 1.');

    await Future.delayed(Duration(seconds: durationInSeconds)); 
    reference.update({'Ring': 0});
    print('Reset Firebase ring value to 0 after $durationInSeconds seconds.');

  Timer(Duration(minutes: 2), () {
          shouldRing.value = true;
          update(); 
        });

  }
}


}

