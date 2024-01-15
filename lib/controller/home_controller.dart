
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {

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


  void fetchScheduleCount() async {
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


// void startLoop() {
//   Timer.periodic(Duration(seconds: 30), (timer) {
//     // Get the current device time
//     DateTime now = DateTime.now();
//     String deviceTime = formatTimeWithAMPM(now);

//     // Check if the current time matches any of the specified times
//   if (deviceTime == '09:43 PM' || deviceTime == '06:30 AM' || deviceTime == '07:00 AM' || deviceTime == '07:45 AM'  || deviceTime == '08:30 AM'  || deviceTime == '09:00 AM'  || deviceTime == '09:30 AM'  || deviceTime == '10:45 AM'  || deviceTime == '11:30 AM'  || deviceTime == '12:15 PM') {
//       // Call the function to check and update Firebase
//       checkAndUpdateFirebase(deviceTime);
//        print('Time matched: $deviceTime');
//       // Pause the timer until the next day to avoid unnecessary calls
    
     
//     }
//   });
// }

void startLoop() {
  Timer.periodic(Duration(seconds: 30), (timer) async {
    // Get the current device time
    DateTime now = DateTime.now();
    String deviceTime = formatTimeWithAMPM(now);

    // Check if the current time matches any of the specified times
    if (deviceTime == '09:43 PM' || deviceTime == '06:30 AM' || deviceTime == '07:00 AM' || deviceTime == '07:45 AM' || deviceTime == '08:30 AM' || deviceTime == '09:00 AM' || deviceTime == '09:30 AM' || deviceTime == '10:45 AM' || deviceTime == '11:30 AM' || deviceTime == '12:15 PM') {
      // Check if the current day is Friday (5) or Saturday (6)
      if (now.weekday != DateTime.friday && now.weekday != DateTime.saturday) {
        // Call the function to check and update Firebase
        await checkAndUpdateFirebase(deviceTime);
        print('Time matched: $deviceTime');
      } else {
        print('Today is Friday or Saturday. Firebase value not changed.');
      }
      // Pause the timer until the next day to avoid unnecessary calls
    }
  });
}

// void checkAndUpdateFirebase(String deviceTime) async {
//   // Get the current device time
//   DateTime now = DateTime.now();
//   DatabaseReference reference =
//       FirebaseDatabase.instance.reference().child('bell');

//   SharedPreferences prefs = await SharedPreferences.getInstance();

//   // Retrieve times from SharedPreferences
//   List<String> storedTimes = prefs.getStringList('stored_times') ?? [];

//   // Check if the current time is in the stored times
//   if (storedTimes.contains(deviceTime)) {
//     print('Time matched one of the stored times. Firebase value not changed.');
//   } else {
//     // Update Firebase value if the current time is not in the stored times
//     reference.update({'ring': 1});
//     print('Updated Firebase ring value to 1.');
//   }

//   Timer(Duration(seconds: 30), () {
//     reference.update({'ring': 0});
//     print('Updated ring to 0 after 30 seconds.');
//   });
// }


// void checkAndUpdateFirebase() {
//   // Get the current device time
//   DateTime now = DateTime.now();
//   DatabaseReference reference = FirebaseDatabase.instance.reference().child('bell');
//     reference.update({'ring': 1});

// Timer(Duration(seconds: 30), () {
//     reference.update({'ring': 0});
//     print('Updated ring to 0 after 30 seconds.');
//   });
// }
  Future<void> checkAndUpdateFirebase(String deviceTime) async {
  DatabaseReference reference = FirebaseDatabase.instance.reference().child('bell');

  SharedPreferences prefs = await SharedPreferences.getInstance();
  Set<String> keys = prefs.getKeys();

  // Check if all times are stopped
  if (keys.any((key) => key == 'stop_all_times') && prefs.getBool('stop_all_times') == true) {
    print('All times are stopped. Firebase value not changed.');
  } else {
    // Check if the specified time is stored in shared preferences
    if (keys.any((key) => key == 'bell_disabled_time_$deviceTime')) {
      print('Time $deviceTime is stored in SharedPreferences. Firebase value not changed.');
    } else {
      // Update Firebase value if the time is not stored
      reference.update({'ring': 1});
      print('Updated Firebase ring value to 1.');
    }
  }

  Timer(Duration(seconds: 30), () {
    reference.update({'ring': 0});
    print('Updated ring to 0 after 30 seconds.');
  });
}


}

