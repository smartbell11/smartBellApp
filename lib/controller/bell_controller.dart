import 'dart:async';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class BellControlController extends GetxController {
   BellControlController() {
    initSwitchStates();
  }
  final Map<String, RxBool> switchStates = {
    '09:43 PM':true.obs,
    '06:30 AM': true.obs,
    '07:00 AM': true.obs,
    '07:45 AM': true.obs,
    '08:30 AM': true.obs,
    '09:00 AM': true.obs,
    '09:30 AM': true.obs,
    '10:45 AM': true.obs,
    '11:30 AM': true.obs,
    '12:15 PM': true.obs,
  };

  final RxBool stopAllTimes = false.obs;

void toggleStopAllTimes(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('stop_all_times', value);
    stopAllTimes.value = value;
    CustomToast.successToast(value ? 'All times stopped' : 'All times resumed');
  }
  Future<bool> isAllTimesStoppedFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('stop_all_times') ?? false;
  }
  bool isAllTimesStopped() {
    return stopAllTimes.value;
  }
  Future<void> initSwitchStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (String time in switchStates.keys) {
      bool isEnabled =
          prefs.getString('bell_disabled_time_$time') != null;
      switchStates[time]!.value = !isEnabled;
    }
  }
  Future<void> printStoredTimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();

    print('Stored Times in SharedPreferences:');
    for (String key in keys) {
      if (key.startsWith('bell_disabled_time_')) {
        String storedTime = prefs.getString(key) ?? '';
        print('$key: $storedTime');
      }
    }
  }
 
  void toggleBellSwitch(String time, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (!value) {
      // Only store the time if the bell is disabled (value is false)
      prefs.setString('bell_disabled_time_$time', time);
      switchStates[time]!.value = value;

      CustomToast.successToast('Bell disabled at $time');

      // Print the changes in SharedPreferences and the updated values of switchStates
      print('Stored in SharedPreferences: bell_disabled_time_$time: $time');
      print('Switch States after toggling: $switchStates');
    } else {
      // If the bell is enabled, remove it from SharedPreferences
      prefs.remove('bell_disabled_time_$time');
      switchStates[time]!.value = value;

      CustomToast.successToast('Bell enabled at $time');

      // Print the removal from SharedPreferences and the updated values of switchStates
      print('Removed from SharedPreferences: bell_disabled_time_$time');
      print('Switch States after toggling: $switchStates');
    }
  }


    void clearPreferencesAfterDay() {
    Timer.periodic(Duration(days: 1), (timer) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear(); // Clears all preferences
      timer.cancel(); // Stop the timer after clearing preferences
    });
  }
}