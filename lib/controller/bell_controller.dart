import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:smart_school_bill/widgets/custom_toast.dart';

class BellControlController extends GetxController {

@override
  void onInit() {
    super.onInit();
      initSwitchStates();
  }

  void updateGlobalSwitchState(bool value) {
    globalSwitchState.value = value;
  }
    FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<List<Map<String, dynamic>>> fetchTimesFromSchedule() async {
  try {
    QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
        await firestore.collection("schedule").get();

    List<Map<String, dynamic>> scheduleData = scheduleSnapshot.docs
        .map<Map<String, dynamic>>((doc) {
          return {
            'selectedStartTime': doc['selectedStartTime'] as String,
            'isStopped': doc['isStopped'] ?? false,
            'docId': doc['docId'] as String,
          };
        })
        .toList();

    return scheduleData;
  } catch (error) {
    print("Error fetching times from schedule: $error");
    return [];
  }
}


  final Map<String, RxBool> switchStates = {};
 final RxBool globalSwitchState = true.obs;

void StopAllTimes() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("schedule").get();
         CustomToast.successToast( 'All times stopped' );
  globalSwitchState.value = false;
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({'isStopped': true});
      }
    } catch (error) {
      print("Error updating Firestore: $error");
      CustomToast.errorToast("Failed to stop all times.");
    }
}
void ResumeAllTimes() async {
    try {
      QuerySnapshot querySnapshot = await firestore.collection("schedule").get();
         CustomToast.successToast( 'All times Resumed' );
 globalSwitchState.value = true;
      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        await document.reference.update({'isStopped': false});
      }
    } catch (error) {
      print("Error updating Firestore: $error");
      CustomToast.errorToast("Failed to stop all times.");
    }
}
 

    Future<void> initSwitchStates() async {
    try {
      QuerySnapshot<Map<String, dynamic>> scheduleSnapshot =
          await firestore.collection("schedule").get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in scheduleSnapshot.docs) {
        String time = doc.id;
        bool isStopped = doc['isStopped'] ?? false;
        switchStates[time] = RxBool(!isStopped);
      }
    } catch (error) {
      print('Error initializing switch states from Firebase: $error');
    }
  }


void toggleBellSwitch(String docId, String time, bool value) async {
  try {
    DocumentReference scheduleRef = firestore.collection("schedule").doc(docId);

    // Check if the document exists before updating
    bool documentExists = (await scheduleRef.get()).exists;

    if (documentExists) {
      if (!value) {
        await scheduleRef.update({'isStopped': true});
        CustomToast.successToast('Bell disabled at $time');
      } else {
        await scheduleRef.update({'isStopped': false});
        CustomToast.successToast('Bell enabled at $time');
      }

      DocumentSnapshot<Map<String, dynamic>> updatedDocument =
          await scheduleRef.get() as DocumentSnapshot<Map<String, dynamic>>;

      bool isStopped = updatedDocument['isStopped'] ?? false;
      switchStates[docId]?.value = !isStopped;

      switchStates[docId]?.refresh();
    } else {
      print('Document $time does not exist in Firestore');
    }
  } catch (error) {
    print('Error updating Firestore: $error');
  }
}





}